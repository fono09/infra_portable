BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

ovs-docker del-port $VSWITCH_NAME $SE_IF0 $SE_CT_NAME
ovs-docker del-port $VSWITCH_NAME $SE_IF1 $SE_CT_NAME

docker rm -f $SE_CT_NAME

