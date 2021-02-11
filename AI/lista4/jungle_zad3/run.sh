#!/bin/bash

# Katalog w ktorym jest plik run.sh
export DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Uwaga na:
# 1. polecenie exec - zastepujepy pythonem basha
# 2. opcje -u - wylaczamy buforowanie we/wy - pomoze nam przy zapomnianych stdout.flush
exec /snap/pypy3/bin/pypy3 -u $DIR/player.py
