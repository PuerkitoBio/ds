import streams

type Options* = object
    ## Options holds the options to use to run the search.
    before*, after*, context*: int # lines in context
    ignoreCase*: bool # case-sensitive or not
    pattern*: string # the regexp pattern to search for
    entries*: seq[string] # the files or top-level directories to search
    sout*, serr*: Stream # the out and err streams to print to

## current is the one and only instance of Options to use when called
## as a program.
var current* = Options(pattern: "",
    entries: @[],
    sout: newFileStream(stdout),
    serr: newFileStream(stderr))
