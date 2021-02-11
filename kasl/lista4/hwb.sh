#!/usr/bin/bash

world=false
greeting="Hello"
color='auto'
capitalize=false
GREEN='\033[0;32m'
NC='\033[0m'

function hello() {
    for i
    do
        if [[ $(echo $i | grep "^-") == $i ]]
        then
            continue
        fi
        if $capitalize
        then
            temp=$(echo $i | sed -e "s/\b\(.\)/\u\1/g")
        else
            temp=$i
        fi
        case $color in
            'always') echo -e "$greeting, ${GREEN}$temp${NC}!";;
            'auto') if [ -t 1 ]; then echo -e "$greeting, ${GREEN}$temp${NC}!"; else echo "$greeting, $temp!"; fi;;
            'never') echo "$greeting, $temp!";;
        esac
    done
    if $capitalize
    then
        temp="World"
    else
        temp="world"
    fi
    if $world
    then
        case $color in
            'always') echo -e "$greeting, ${GREEN}$temp${NC}!";;
            'auto') if [ -t 1 ]; then echo -e "$greeting, ${GREEN}$temp${NC}!"; else echo "$greeting, $temp!"; fi;;
            'never') echo "$greeting, $temp!";;
        esac
    fi
    exit
}


function help() {
    echo "Welcome to hwb - program to greet anything"
    echo
    echo "hwb [OPTIONS] {ARGS...}"
    echo "Greets strings put in {ARGS...}"
    echo
    echo "available options are:"
    echo "-c --capitalize makes all characters capitalise"
    echo "-g {text} --greeting=text greets you with text word"
    echo "-h --help shows this instruction"
    echo "-v --version version of this program"
    echo "-w --world prints aditional line with 'wolrd' argument"
    echo "--color=[always|auto|never] (default auto)"
    exit
}

function version() {
    echo "Version 1.0"
    echo "Copyrights (C) 2020 Mikołaj Korobczak"
    echo "Wyłączeni na użytek własny lub na zaliczenie kursu administrowania systemem linux"
    exit
}

function check() {
    TEMP=`getopt -o chvwg: --long capitalize,help,version,world,color:,greeting: -- "$@"`
    eval set -- "$TEMP"
    while true
    do
        case $1 in
            --color) shift; color="$1"; shift;;
            -g | --greeting) shift; greeting="$1"; shift;;
            -c | --capitalize) capitalize=true; shift;;
            -h | --help) help;;
            -v | --version) version;;
            -w | --world) world=true; shift;;
            --) break;;
            *) shift;;
            -? | --?*) help;;
        esac
    done
    hello $@
    exit
}

check $@
