на роутере
sudo nmcli con add type ethernet ifname enp0s3 con-name internal ipv4.addresses 192.168.10.1/24 ipv4.method manual
sudo nmcli con up internal

echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

sudo iptables -t nat -A POSTROUTING -o enp0s8 -j MASQUERADE
sudo iptables -D FORWARD 1

sudo iptables-save | sudo tee /etc/iptables.rules


sudo dnf install dhcp-server -y

echo 'subnet 192.168.10.0 netmask 255.255.255.0 {
    range 192.168.10.100 192.168.10.200;
    option routers 192.168.10.1;
    option domain-name-servers 8.8.8.8;
    default-lease-time 600;
    max-lease-time 7200;
}' | sudo tee -a /etc/dhcp/dhcpd.conf

echo 'DHCPDARGS=enp0s3' | sudo tee -a /etc/sysconfig/dhcpd


sudo systemctl enable --now dhcpd
