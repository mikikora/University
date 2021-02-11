#!/usr/bin/bash

primes[0]=2
i=1
n=2
while [[ $n -lt $1 ]]
do
    n=$(($n + 1))
    j=0
    while [[ $((${primes[$j]} * ${primes[$j]})) -le $n ]]
    do
        if [[ $(($n % ${primes[$j]})) = 0 ]]
        then
            continue 2
        fi
        j=$(($j + 1))
    done
    primes[$i]=$n
    i=$(($i + 1))
done

for (( k=0; k < $i; k++ ))
do
    echo ${primes[$k]}
done | column -x
