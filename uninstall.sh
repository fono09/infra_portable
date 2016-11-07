source settings.env


## SoftEtherVPN
ovs-docker del-port $VSWITCH_NAME veth0 $SE_CT_NAME
ovs-docker del-port $VSWITCH_NAME veth1 $SE_CT_NAME

docker rm -f $SE_CT_NAME

## OpenvSwtich
ovs-vsctl del-port $VSWITCH_NAME $IFACE
ovs-vsctl del-br $VSWITCH_NAME

ip link set $IFACE promisc off
