source ../settings.env

ovs-docker del-port $VSWITCH_NAME veth0 $SE_CT_NAME
ovs-docker del-port $VSWITCH_NAME veth1 $SE_CT_NAME

docker rm -f $SE_CT_NAME

