#!/bin/bash

set -e

while getopts "h" option; do
    case ${option} in
        h|help)
            echo "rgx f|find|v|validate PATTERN [FILE]"
            echo "rgx r|replace PATTERN/PATTERN [FILE]"
            exit 0
            ;;
    esac
done
shift $((OPTIND -1))

command=$1;
if [ "$command" == '' ]; then
    rgx -h
    exit 0
fi
shift
case "$command" in
    f|find)    
        grep -n --color=auto $1 $2
        ;;
    r|replace)
        perl -0777 -pe "s/$1/sg" $2
        ;;    
    v|validate)
        perl -0777 -ne "if ( /^$1\$/sg ) { print 1 } else { print 0 }" $2
        ;;
    *)
        rgx -h
        ;;
esac
