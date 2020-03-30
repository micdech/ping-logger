#!/bin/bash
data=`date`
emails="micdech@gmail.com"
subject="invio mail automatica from pinger-tools"
# Definisco host da testare nel ciclo for

# può essere anche array separato da spazi (es: www.ilcrivello.it www.google.com etc)
for i in www.ilcrivello.dec
do
echo "$data Host $i test start" >> /var/log/ping-logger.log

((count = 10))                            # Maximum number to try.
while [[ $count -ne 0 ]] ; do
    ping -c 1 $i >> /var/log/ping-logger.log # Try once.
    rc=$?
    if [[ $rc -eq 0 ]] ; then
        ((count = 1))                      # If okay, flag to exit loop.
    fi
    ((count = count - 1))                  # So we don't go forever.
done

if [[ $rc -eq 0 ]] ; then                  # Make final determination.
    echo "$data Host $i is up." >> /var/log/ping-logger.log
else
    echo "$data Host $i is unreachable." >> /var/log/ping-logger.log
    if (( $(ps -ef | grep -v grep | grep apache2 | wc -l) > 0 ))
		then
			echo "$data Apache webserver is running, try to restart HAproxy Varnish && Apache" >> /var/log/ping-logger.log
			echo `service apache2 restart`
			echo `service varnish restart`
			echo `service haproxy restart`
			echo "Apache, Varnish & HAProxy for $i was stopped and now are started!!!" | mail -s "$subject" $emails
	else
			echo "$data Apache webserver is running, try to restart HAproxy Varnish && Apache" >> /var/log/ping-logger.log
			echo `service apache2 start`
			echo `service varnish start`
			echo `service haproxy start`
			echo "Apache, Varnish & HAProxy for $i are now restarted due possible choke!!!" | mail -s "$subject" $emails

	fi
fi

done
