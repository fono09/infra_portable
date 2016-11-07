source settings.env

## OpenvSwtich
ip link set $IFACE promisc on

ovs-vsctl add-br $VSWITCH_NAME
ovs-vsctl add-port $VSWITCH_NAME $IFACE

## SoftEtherVPN
docker run -d --cap-add NET_ADMIN --privileged --name $SE_CT_NAME --net=none \
        -e PSK=$PSK -e USERS="${USERS}" -e SPW=$SPW -e HPW=$HPW \
        siomiz/softethervpn

ovs-docker add-port $VSWITCH_NAME veth0 $SE_CT_NAME --ipaddress=$SE_CT_ADDR --gateway=$CT_GATEWAY
ovs-docker add-port $VSWITCH_NAME veth1 $SE_CT_NAME --ipaddress=0.0.0.0
