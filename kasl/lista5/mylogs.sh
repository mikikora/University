#!/usr/bin/bash

FIFO="/tmp/mylog.fifo"
function foo() {
    if ! [[ -e $FIFO ]]
    then
        mkfifo $FIFO
    fi
    while true
    do
        cat $FIFO
        echo $(date "+%Y%m%d%H%M%S" | sed "s/\([0-9]\{4\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)\([0-9]\{2\}\)/\1-\2-\3 \4:\5:\6/")
        echo

    done
}
foo
# foo &
# while true
# do
#     read -s -t 1 -n 1 button
#     if [[ $? == 0 ]]
#     then
#         kill $(ps aux | grep --color=never "cat /tmp/mylog.fifo$" | awk '{ print $2 }') | exit
#     fi
# done
