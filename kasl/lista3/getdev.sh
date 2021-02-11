#!/usr/bin/bash

if [[ $1 == "" ]]
then
    exit
fi

search=$(echo $1 | sed 's/\(.\)\/$/\1/')

test=$(cat /etc/fstab | grep "^[^#]*$search")
printf "Device:\t\t\t%s\n" $(echo $test | awk '{print $1}')
printf "File system:\t\t%s\n" $(echo $test | awk '{print $3}')
printf "Mount option:\t\t%s\n" $(echo $test | awk '{print $4}')
printf "Dump freqency:\t\t%s\n" $(echo $test | awk '{print $5}')
printf "Fsck pass number:\t%s\n" $(echo $test | awk '{print $6}')
