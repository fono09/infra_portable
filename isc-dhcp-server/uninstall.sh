BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

ovs-docker del-port $VSWITCH_NAME $DHCP_IF0 $DHCP_CT_NAME

docker rm -f $DHCP_CT_NAME
