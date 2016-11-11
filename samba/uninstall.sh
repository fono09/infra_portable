source ../settings.env

ovs-docker del-port $VSWITCH_NAME veth0 $SMB_CT_NAME

docker rm -f $SMB_CT_NAME
