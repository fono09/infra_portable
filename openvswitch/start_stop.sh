BASE_DIR=$(cd $(dirname $0); pwd)
source $BASE_DIR/../settings.env

if [ $1 == "start" ]; then

	ip link set $IFACE promisc on

	ovs-vsctl add-br $VSWITCH_NAME
	ovs-vsctl add-port $VSWITCH_NAME $IFACE

	exit 0

elif [ $1 == "stop" ]; then

	ovs-vsctl del-port $VSWITCH_NAME $IFACE
	ovs-vsctl del-br $VSWITCH_NAME

	ip link set $IFACE promisc off

	exit 0
else
	echo 'usage: start_stop.sh {start|stop}'

	exit 1
fi

