#AWS_WireGuard
#Ubuntu 20
#How to Use AWS EC2 to set up a VPN using WireGuard 
#Note: "sudo su" is required for running wiregaurd (wg), accessing /etc/wireguard directories, and running scripts in this repository.
#Open the AWS CLI
https://us-east-2.console.aws.amazon.com/cloudshell/home?region=us-east-2
#and run the following...
git clone https://github.com/kcash333/AWS_WireGuard
cd AWS_WireGuard
bash aws_wireguard_cli_start.sh
#Once this is done on the AWS CLI, SSH into EC2 instance and run:
cd ~/wg-setup/AWS_WireGuard
sudo bash wg_add_peer_device#.sh
#Make sure you plan out the device number, IP in 10.0.0.x format, and have any Public Keys from the device you wish to connect before running this script because it will take down the wg0 Interface.

#Using peer: Win10
#Windows installer can be found here...
https://www.wireguard.com/install/
#Windows 10 Requires a DNS configuration, DNS = 1.1.1.1 added to the interface settings

#Using peer: Linux
#Comming in the future.
