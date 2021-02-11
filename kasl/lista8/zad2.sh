#!/bin/bash

# W momencie gdy uruchamiam poniższy skrypt poleceniem #sudo nice -n -20 bash zad2.sh wszystkie rdzenie procesora mam zajęte w 100%, a komputer znacznie spowalnia swoje działanie
# Gdy używam polecenia sudo renice 19 $( pgrep bash ) komputer znacznie przyspiesz mimo, że wszystkie rdzenie wciąż są obciążone w 100%


calculate() {
    a=0
    while [[ $a != 5 ]]
    do
        a=$(( 2 + 2 ))
    done
    return $a
}


for (( i=0; i < $1; i++ ))
do
    calculate &
done
