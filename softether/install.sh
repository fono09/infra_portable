BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

docker run -d --cap-add NET_ADMIN --privileged --name $SE_CT_NAME --net=none \
	-v `pwd`/vpn_server.config:/opt/vpn_server.config \
        siomiz/softethervpn

ovs-docker add-port $VSWITCH_NAME $SE_IF0 $SE_CT_NAME --ipaddress=$SE_CT_ADDR --gateway=$CT_GATEWAY
ovs-docker add-port $VSWITCH_NAME $SE_IF1 $SE_CT_NAME --ipaddress=0.0.0.0

