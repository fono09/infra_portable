source ../settings.env

sh -c "docker run -d --name $SMB_CT_NAME --net=none $SMB_VOLUMES dperson/samba ${SMB_OPTIONS}"

ovs-docker add-port $VSWITCH_NAME veth0 $SMB_CT_NAME --ipaddress=$SMB_CT_ADDR --gateway=$CT_GATEWAY
