#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

case "$1" in
	"start" )
		sh -c "docker run -d --privileged --name $SMB_CT_NAME --net=none $SMB_VOLUMES dperson/samba ${SMB_OPTIONS}"
		ovs-docker add-port $VSWITCH_NAME $SMB_IF0 $SMB_CT_NAME --ipaddress=$SMB_CT_ADDR --gateway=$CT_GATEWAY
	;;
	"stop" )
		ovs-docker del-port $VSWITCH_NAME $SMB_IF0 $SMB_CT_NAME
		docker rm -f $SMB_CT_NAME
	;;
	* )
		echo "Usage: start_stop.sh {start|stop}"
	;;	
esac
