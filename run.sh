#!/bin/bash
clear

echo "===========NEXUS======= " && sleep 1

sudo tee /etc/systemd/system/nexus.service > /dev/null <<EOF
[Unit]
Description=NEXUS
After=network-online.target
[Service]
WorkingDirectory=/root
ExecStart=/usr/bin/curl https://cli.nexus.xyz | /usr/bin/sh
Restart=always
Environment="PATH=/root/.cargo/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
StandardOutput=append:/root/nexus-ln.log
StandardError=append:/root/nexus-ln.log
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
sudo systemctl daemon-reload
sudo systemctl enable nexus
sudo systemctl restart nexus
