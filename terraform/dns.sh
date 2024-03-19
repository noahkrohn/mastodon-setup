#!/bin/bash

PS=$1

KEY=EG3NFE5P2PCL7JUS
UUID=`uuidgen`
CMD=dns-list_records
 
# ARGS='other_http_get_arguments_for_the_DreamHost_cmd_that_you_are_using=4&foo=123'
LINK="https://api.dreamhost.com/?key=$KEY&unique_id=$UUID&cmd=$CMD"

RESPONSE=`wget -O- -q "$LINK"`
#echo $RESPONSE
#array=($( echo $RESPONSE | tr ";\n" "; "))
array=($( echo $RESPONSE ))
for ((i=0; i<8; i++)); do unset array[$i]; done

#for i in "${array[@]}"; do echo $i; done
len=${#array[@]}
for ((i=0; i<$len; i++)); do echo "${array[$i]}"; done
