#!/usr/bin/bash

function gen_num() {
    for ((i=2;i<=$1;i++))
    do
        echo $i
    done
}

function sieve() {
    read first
    if [[ $? != 0 ]]
    then
        return
    fi
    echo $first
    read next
    while [[ $? == 0 ]]
    do
        if [[ $(($next % $first)) != 0 ]]
        then
            echo $next
        fi
        read next
    done | sieve &
}

gen_num $1 | sieve | column -x
