BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/$BASE_DIR/../settings.env

ip link set $IFACE promisc on

ovs-vsctl add-br $VSWITCH_NAME
ovs-vsctl add-port $VSWITCH_NAME $IFACE
