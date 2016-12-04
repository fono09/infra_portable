#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

case "$1" in
	"start" )
		docker run -d --net=none --name $XX_CT_NAME ubuntu /bin/bash
		ovs-docker add-port $VSWITCH_NAME $XX_IF0 $XX_CT_NAME --ipaddress=$XX_CT_ADDR --gateway=$CT_GATEWAY
		exit 0
	;;
	"stop" )
		ovs-docker del-port $VSWITCH_NAME $XX_IF0 $XX_CT_NAME
		docker rm -f $XX_CT_NAME
		exit 0
	;;
	* )
		echo "Usage: start_stop.sh {start|stop}"
		exit 1
	;;
esac
