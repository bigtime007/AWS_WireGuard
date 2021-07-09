#!/bin/bash
sudo su
apt-get update && apt-get upgrade -y
NET_FORWARD="net.ipv4.ip_forward=1"
sysctl -w  ${NET_FORWARD}
sed -i "s:#${NET_FORWARD}:${NET_FORWARD}:" /etc/sysctl.conf
apt-get install wireguard -y
cd /etc/wireguard
umask 077
SERVER_PRIVKEY=$( wg genkey )
SERVER_PUBKEY=$( echo $SERVER_PRIVKEY | wg pubkey )
echo $SERVER_PUBKEY > ./publickey
echo $SERVER_PRIVKEY > ./privatekey
cat > ./wg0.conf.def << EOF
[Interface]
PrivateKey = $SERVER_PRIVKEY
Address = 10.0.0.1/24
ListenPort = 51820
PostUp = iptables -A FORWARD -i wg0 -j ACCEPT; iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
PostDown = iptables -D FORWARD -i wg0 -j ACCEPT; iptables -t nat -D POSTROUTING -o eth0 -j MASQUERADE
EOF
cp -f ./wg0.conf.def ./wg0.conf
systemctl enable wg-quick@wg0
mkdir -p /home/ubuntu/wg-setup
cd /home/ubuntu/wg-setup
echo "run as:sudo wg_add_peer_device#.sh" > run_wg_add_peer_device#.sh_as_sudo.txt
git clone https://github.com/kcash333/AWS_WireGuard
cd /home/ubuntu/
chown -hR ubuntu wg-setup/
git clone https://github.com/kcash333/AWS_install_NFS_Ubuntu20
chmod 0777 AWS_install_NFS_Ubuntu20
exit
