# Amazon SSM Agent on CoreOS Container Linux 

### Usage:

- Run once and install amazon-ssm-agent to `/opt/bin/` 
  - `/usr/bin/docker run -v /tmp:/ssm -v /etc:/ssm/etc -v /opt:/ssm/usr -v /var:/ssm/var <DOCKER_CONTAINER_NAME>`
- Have systemd manage it
 ```[Unit]
Description=amazon-ssm-agent
After=network-online.target
[Service]
Type=simple
WorkingDirectory=/usr/bin/
ExecStartPre=/usr/bin/docker pull <DOCKER_CONTAINER_NAME>
ExecStartPre=/usr/bin/docker run -v /tmp:/ssm  -v /etc:/ssm/etc  -v /opt:/ssm/usr  -v /var:/ssm/var <DOCKER_CONTAINER_NAME>
ExecStart=/opt/bin/amazon-ssm-agent
KillMode=process
Restart=on-failure
RestartSec=15min
[Install]
WantedBy=multi-user.target
```

### Behind the Scenes

1. It downloads the latest rpm for the SSM agent from AWS
`curl -sSl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o amazon-ssm-agent.rpm`
2. It uses `rpm2cpio` to convert the rpm package to a cpio archive
3. Once the cpio archive is generated, it can be unpacked by running `cpio -idmv`
4. List of files extracted
```./etc/amazon/ssm/README.md
./etc/amazon/ssm/RELEASENOTES.md
./etc/amazon/ssm/amazon-ssm-agent.json.template
./etc/amazon/ssm/seelog.xml.template
./etc/init/amazon-ssm-agent.conf
./etc/systemd/system/amazon-ssm-agent.service
./usr/bin/amazon-ssm-agent
./usr/bin/ssm-cli
./usr/bin/ssm-document-worker
./usr/bin/ssm-session-logger
./usr/bin/ssm-session-worker
./var/lib/amazon/ssm
```
5. Start `amazon-ssm-agent`