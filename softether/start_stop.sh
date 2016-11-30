#!/bin/bash

BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

if [ $1 == "start" ]; then

	docker run -d --cap-add NET_ADMIN --privileged --name $SE_CT_NAME --net=none \
		-v $BASE_DIR/vpn_server.config:/opt/vpn_server.config \
		siomiz/softethervpn

	ovs-docker add-port $VSWITCH_NAME $SE_IF0 $SE_CT_NAME --ipaddress=$SE_CT_ADDR --gateway=$CT_GATEWAY
	ovs-docker add-port $VSWITCH_NAME $SE_IF1 $SE_CT_NAME --ipaddress=0.0.0.0

elif [ $1 == "stop" ]; then

	ovs-docker del-port $VSWITCH_NAME $SE_IF0 $SE_CT_NAME
	ovs-docker del-port $VSWITCH_NAME $SE_IF1 $SE_CT_NAME

	docker rm -f $SE_CT_NAME

else

	echo "Usage: start_stop.sh {start|stop}"

fi

