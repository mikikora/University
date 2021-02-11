#!/usr/bin/bash

total=0
for i
do
    s=$(du -s "$i" | awk '{print $1}')
    total=$(( $total + $s ))
done
df | awk -v sum="$total" '{if ($4 >= sum) print}'
