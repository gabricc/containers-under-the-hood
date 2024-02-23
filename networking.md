## Networking
# Em outro shell, habilite o roteamento com:
sysctl net.ipv4.ip_forward=1
# Criando interface bridge:
bridge link
ip link add name br0 type bridge
ip link set br0 up
bridge link
# Criando parzinho de interfaces veth:
ip link list
ip link add veth0 type veth peer name veth1
ip link list
# Atribuindo interface de rede veth1 ao namespace de rede do nosso container:
ip link set veth1 netns $(pidof unshare)
# Observe que ela desaparecerá do namespace global:
ip link
# Subindo os pares de interface e atribuindo um endereço IP:
ip link set veth0 up
ip link set veth0 master br0
ip address add 192.168.15.71/24 dev br0
# No shell do container:
ip link set veth1 up
ip address add 192.168.15.72/24 dev veth1
# De dentro do container, testando conectividade:
ping 192.168.15.71
# Setup route to internet
ip route add 0.0.0.0/0 via 192.168.15.1 dev veth1
