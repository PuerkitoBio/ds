import os, options, sets, sequtils, cpuinfo, threadpool, streams, strutils

var cores = max(countProcessors(), 1)

proc resolveFiles(entry: string, tbl: var HashSet[string]) =
    for file in walkDirRec(entry):
        incl(tbl, file)

proc searchFile(file: string, pat: string) =
    let fs = newFileStream(file, fmRead)
    defer: fs.close()

    var data: TaintedString = ""
    var line = 0
    var headWritten = false
    while fs.readLine(data):
        inc(line)
        if contains(data.string, pat):
            if not headWritten:
                echo file
                headWritten = true

            echo line, ": ", data

    if headWritten: echo ""

proc searchFiles(files: seq[string], pat: string) =
    for file in files:
        searchFile(file, pat)

proc search*(opts: Options) =
    var tbl = initSet[string]()

    # first find all unique files to search
    for entry in opts.entries:
        resolveFiles(entry, tbl)

    # get a seq from the keys, distribute among cores
    let keys = toSeq(tbl.items)
    let perCore = distribute(keys, cores)

    # search in parallel
    parallel:
        for i in 0..perCore.high:
            spawn searchFiles(perCore[i], opts.pattern)
