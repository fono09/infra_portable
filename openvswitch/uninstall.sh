source ../settings.env

ovs-vsctl del-port $VSWITCH_NAME $IFACE
ovs-vsctl del-br $VSWITCH_NAME

ip link set $IFACE promisc off
