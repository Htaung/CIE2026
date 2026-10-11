#### Creating non root user for deployment
sudo useradd -M -s /usr/sbin/nologin portal

```
sudo mkdir -p /opt/app
git clone https://github.com/nicholasjackson/fake-service/releases/download/v0.26.2/fake_service_linux_amd64.zip

unzip fake_service_linux_amd64.zip
cp fake-service /opt/app
chmod +x fake-service
chown -R portal:portal /opt/app
```

### SYSTEMD service for profile-service
- sudo nano /etc/systemd/system/fake-service.service
```

[Unit]
Description=profile-svc fake-service
After=network.target

[Service]
WorkingDirectory=/opt/app
Environment=NAME="Profile Service"
Environment=LISTEN_ADDR=0.0.0.0:9091
Environment="MESSAGE=Response from Profile Service"
Environment=UPSTREAM_URIS=http://172.16.3.82:9092
ExecStart=/opt/app/fake-service
Restart=always
User=portal

[Install]
WantedBy=multi-user.target

```

### ENABLE SYSTEMD
- sudo systemctl daemon-reload
- sudo systemctl enable fake-service
- sudo systemctl restart fake-service
- sudo systemctl status fake-service
-  ss -tulpn | grep 9093


#### 
```

[Unit]

Description=Statement service

After=network-online.target

Wants=network-online.target



[Service]

Type=simple

Environment="LISTEN_ADDR=0.0.0.0:9093"

Environment="NAME=Statement Service"

Environment="MESSAGE=this is from Statement Service"

ExecStart=/opt/app/fake-service

User=portal

Group=portal

Restart=always

RestartSec=5



[Install]

WantedBy=multi-user.target


```



### Intra Region VPC Peering lab
![](./VPC-Peering.drawio.svg)