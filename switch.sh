export DEBIAN_FRONTEND=noninteractive
apt-get update
apt-get install -y tcpdump apt-transport-https ca-certificates curl software-properties-common --assume-yes --force-yes
apt-get install -y openvswitch-common openvswitch-switch --assume-yes --force-yes
ovs-vsctl add-br switch
ovs-vsctl add-port switch eth1
ovs-vsctl add-port switch eth2 tag=10
ovs-vsctl add-port switch eth3 tag=20
ip link set eth1 up
ip link set eth2 up
ip link set eth3 up
ip link set dev ovs-system up
