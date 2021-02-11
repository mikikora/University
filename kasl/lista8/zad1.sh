#!/bin/bash

trap ':' 1
trap 'logger "got SIGUSR1 signal"; exit' 10
while true
do
    # date
    logger `date`
    sleep 3
done


# Po uruchomieniu tego pliku w tle, proces ten zostaje zabity przy zakończeniu pracy konsoli.
# Po dodaniu polecenia nohup takie zdarzenie nie ma miejca
# Komunikaty, które pownny być skierowane na standardowe wyjście są zapisywane do pliku ./nohup.out
# Ja zamykam taki proces poleceniem killall bash albo pkill bash
