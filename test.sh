#!/usr/bin/env zsh 

# stdout(1) redirect to /dev/null; so does stderr(2) redirect to stdout(&1)
tool_installed(){
    if hash $1 2>/dev/null; then
        return 1
    else
        return 0
    fi
}

tool_installed egrep
if [[ $(tool_installed PREXG)  -eq 0 ]] ; then
    echo "\t\tPREXG not installed\n\n"
fi

