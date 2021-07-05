#!/bin/bash
cd /etc/wireguard
echo "----------------------------------------------------------------------------"
echo "----------------------------------------------------------------------------"
echo "This will bash Script allows you to setup Device#"
echo "IMPORTANT Running This Script will DISABLE wg0 Interface Momentarily."
echo "Active connections will be temporarily interrupted."
echo "----------------------------------------------------------------------------"
echo "What is the Device Number?"
read DEVICE_NUM
echo "---------------------------------------------------"
echo "What is Device#'s Public Key? (located on Win10)"
read DEVICE1_PUBKEY
echo "---------------------------------------------------"
echo "Assign Device#'s IP Address,example 10.0.0.x"
read DEVICE_IP
cat >> ./wg0.conf << EOF

[Peer]
# Device $DEVICE_NUM
PublicKey=$DEVICE1_PUBKEY
AllowedIPs=$DEVICE_IP
PersistentKeepalive=25
EOF
echo "----------------------------------------------------------------------------"
echo "Public Key is now added to Device on on Peer on wg0 .conf File. "
echo "----------------------------------------------------------------------------"
wg-quick down wg0
wg-quick up wg0
echo "----------------------------------------------------------------------------"
echo "CHECKING WIREGURAD SERVER STATUS"
sudo systemctl status wg-quick@wg0
echo "----------------------------------------------------------------------------"
echo "Just make sure Wireguard Interface wg0 above is Enabled "
echo "You will also need this Public key for Device#'s Peer settings"
cat publickey
echo "----------------------------------------------------------------------------"