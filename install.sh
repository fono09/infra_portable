source settings.env

## OpenvSwtich
ip link set $IFACE promisc on

ovs-vsctl add-br $VSWITCH_NAME
ovs-vsctl add-port $VSWITCH_NAME $IFACE

## SoftEtherVPN
docker run -d --cap-add NET_ADMIN --privileged --name $CT_NAME --net=none \
        -e PSK=$PSK -e USERS="${USERS}" -e SPW=$SPW -e HPW=$HPW \
        siomiz/softethervpn

ovs-docker add-port $VSWITCH_NAME veth0 $CT_NAME --ipaddress=$CT_ADDR --gateway=$CT_GATEWAY
ovs-docker add-port $VSWITCH_NAME veth1 $CT_NAME --ipaddress=0.0.0.0

docker cp ./vpn_server.config $CT_NAME:/opt/
docker cp ./softether.in $CT_NAME:/opt/

docker exec -it $CT_NAME /opt/vpncmd localhost:443 /SERVER /PASSWORD:$SPW /CMD:"ConfigSet vpn_server.config"

