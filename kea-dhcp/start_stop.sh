#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

if [ $1 == "start" ]; then

	docker run -d --privileged --name $DHCP_CT_NAME --net=none \
		-v $BASE_DIR/kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf chakphanu/kea

	ovs-docker add-port $VSWITCH_NAME $DHCP_IF0 $DHCP_CT_NAME --ipaddress=$DHCP_CT_ADDR --gateway=$CT_GATEWAY

elif [ $1 == "stop" ]; then

	ovs-docker del-port $VSWITCH_NAME $DHCP_IF0 $DHCP_CT_NAME

	docker rm -f $DHCP_CT_NAME

else
	echo 'usage: start_stop.sh {start|stop}'
fi

