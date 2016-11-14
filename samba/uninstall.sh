BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

ovs-docker del-port $VSWITCH_NAME $SMB_IF0 $SMB_CT_NAME

docker rm -f $SMB_CT_NAME
