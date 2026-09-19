#!/bin/bash
set -e

echo "=== 1. System Update & Dependencies ==="
sudo apt update && sudo apt upgrade -y
sudo apt install -y curl git ufw fail2ban ca-certificates docker.io docker-compose-plugin

echo "=== 2. Kernel Tuning (BBR & UDP Buffers) ==="
cat <<EOF | sudo tee /etc/sysctl.d/99-vps-tuning.conf
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
net.core.rmem_max=67108864
net.core.wmem_max=67108864
net.core.rmem_default=33554432
net.core.wmem_default=33554432
EOF
sudo sysctl --system

echo "=== 3. Firewall Configuration (UFW) ==="
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp comment 'SSH'
sudo ufw allow 48291/tcp comment '3x-ui Panel'
sudo ufw allow 8443/udp comment 'Hysteria 2'
sudo ufw allow 8443/tcp comment 'VLESS Reality'
echo "y" | sudo ufw enable

echo "=== Setup Completed Successfully! ==="
