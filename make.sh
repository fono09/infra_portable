export BASE_DIR=$(cd $(dirname $0); pwd)
cat infra-portable-openvswitch.service.pre | envsubst '$BASE_DIR' > infra-portable-openvswitch.service
cat infra-portable@.service.pre | envsubst '$BASE_DIR' > infra-portable@.service
