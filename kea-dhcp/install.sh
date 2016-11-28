BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

docker run -d --privileged --name $DHCP_CT_NAME --net=none \
	-v $BASE_DIR/kea-dhcp4.conf:/etc/kea/kea-dhcp4.conf chakphanu/kea

ovs-docker add-port $VSWITCH_NAME $DHCP_IF0 $DHCP_CT_NAME --ipaddress=$DHCP_CT_ADDR --gateway=$CT_GATEWAY

