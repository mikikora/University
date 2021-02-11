#!/usr/bin/bash

end=0
while [ $end == 0 ]
do
poolsize=$(cat /proc/sys/kernel/random/poolsize)
avail=$(cat /proc/sys/kernel/random/entropy_avail)
printf "Available entropy: %d/%d\r" $avail $poolsize
read -s -t 1 -n 1 button
if [ $? == 0 ]
then
    end=1
fi
done
