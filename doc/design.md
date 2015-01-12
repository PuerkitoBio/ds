# ds - the dust searcher

A more humble alternative to `grep` and `ack` than `the silver searcher` and `the platinum searcher`. More like an excuse to learn `nim`.

## Basic Features

At the very least, `ds` should support this usage:

```
$ ds [options] PATTERN [FILE...]

NAME
    
    ds - the dust searcher, print lines matching a pattern.

DESCRIPTION

    ds searches input FILEs for lines containing a match to the given PATTERN.
    If no FILEs are specified, the current directory is searched, recursively.
    Files starting with a dot (.) are ignored by default.

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
```
