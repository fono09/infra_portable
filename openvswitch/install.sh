source ../settings.env

ip link set $IFACE promisc on

ovs-vsctl add-br $VSWITCH_NAME
ovs-vsctl add-port $VSWITCH_NAME $IFACE
