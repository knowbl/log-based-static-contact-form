#!/bin/bash

EMAIL="hello@example.com"
EMAILSUBJECT="Contact form"
LOG="/home/example/logs/static-contact-access.log"
CRON="/home/example/logs/example-cron.log"

### DO NOT EDIT BELOW ###

NOW=$(date +"Form sent to $EMAIL -- %Y-%m-%d %H:%M:%S --");

if [ ! -f $LOG ];
then
	printf "." >> $CRON
else
	mail -s "$EMAILSUBJECT" $EMAIL < $LOG;
	printf "\n \n $NOW \n \n" >> $CRON
fi