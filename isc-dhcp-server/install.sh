BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

docker run -it --net=none --name $DHCP_CT_NAME -v $BASE_DIR/data:/data 

ovs-docker add-port $VSWITCH_NAME $DHCP_IF0 $DHCP_CT_NAME --ipaddress=$DHCP_CT_ADDR --gateway=$CT_GATEWAY
