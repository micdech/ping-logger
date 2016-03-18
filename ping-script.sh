#!/bin/bash

data=`date`
# Definisco host da testare nel ciclo for

for i in 8.8.8.8 8.8.4.4 1.1.1.1
do

((count = 10))                            # Maximum number to try.
while [[ $count -ne 0 ]] ; do
    ping -c 1 $i > /dev/null                     # Try once.
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))                      # If okay, flag to exit loop.
    fi
    ((count = count - 1))                  # So we don't go forever.
done

if [[ $rc -eq 0 ]] ; then                  # Make final determination.
    echo "$data Host $i is up." > /dev/null
else
    echo "$data Host $i is unreachable." >> /var/log/ping-logger.log
fi

done
