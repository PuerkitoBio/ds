import parseopt2, strutils, options, searcher

proc showHelp() =
    ## showHelp prints the help screen.
    
    echo """

NAME
    
    ds - the dust searcher, print lines matching a pattern.

DESCRIPTION

    ds searches input FILEs for lines containing a match to the given PATTERN.
    If no FILEs/DIRs are specified, the current directory is searched, 
    recursively. Files starting with a dot (.) are ignored by default.

OPTIONS

    -A NUM, --after-context=NUM
        Place NUM lines of trailing context after matching lines.

    -B NUM, --before-context=NUM
        Place NUM lines of leading context before matching lines.

    -C NUM, --context=NUM
        Place NUM lines of output context.

    --help
        Output a brief help message.

    -i, --ignore-case
        Ignore case distinctions in both the PATTERN and the input files.
"""

proc usageAndExit(code: int) =
    ## usageAndExit prints the usage message followed by the help
    ## screen, and exits the program with the specified exit code.
    
    echo "usage: ds [options] PATTERN [FILE|DIR...]"
    showHelp()
    quit code

proc parseOptions() =
    ## parseOptions parses the command-line flags and arguments.

    for kind, k, v in getopt():
        case kind
            of cmdArgument:
                # argument is either a pattern or a file/directory entry
                if current.pattern.len == 0:
                    current.pattern = k
                else:
                    current.entries.add(k)

            of cmdLongOption, cmdShortOption:
                try:
                    case k
                        of "A", "after-context":
                            current.after = parseInt(v)

                        of "B", "before-context":
                            current.before = parseInt(v)

                        of "C", "context":
                            current.context = parseInt(v)

                        of "i", "ignore-case":
                            current.ignoreCase = true

                        of "h", "help":
                            usageAndExit(QuitSuccess)

                        else:
                            echo "Unknown option: ", k
                            usageAndExit(QuitFailure)
                except:
                    echo "Invalid value for ", k
                    usageAndExit(QuitFailure)

            of cmdEnd: assert(false)

proc run() =
    ## run parses the command-line options and executes the command.
    
    parseOptions()
    if len(current.entries) == 0: current.entries.add(".")
    # if no pattern, list files that would be searched? or error?
    search(current)

when isMainModule:
    run()

