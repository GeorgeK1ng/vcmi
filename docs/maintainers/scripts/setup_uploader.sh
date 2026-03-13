#!/bin/bash

useradd -m -s /usr/sbin/nologin uploader
mkdir -p /home/uploader/uploads
mkdir -p /home/uploader/.ssh
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGfZ1TNzHf7ECsC32/9dSHViMoJMMq/e1kB4NV9i6SDY root@vcmi-web" >/home/uploader/.ssh/authorized_keys

chown root:root /home/uploader
chown uploader:uploader /home/uploader/uploads
chown -R uploader:uploader /home/uploader/.ssh

chmod 755 /home/uploader
chmod 333 /home/uploader/uploads
chmod 700 /home/uploader/.ssh
chmod 600 /home/uploader/.ssh/authorized_keys

echo "Append content of sftpd_config_uploader to /etc/ssh/sshd_config"


useradd -m -s /bin/false downloader
mkdir -p /home/uploader/uploads
mkdir -p /home/uploader/.ssh

useradd -m -s /bin/false downloader

(crontab -l 2>/dev/null; echo "* * * * * /root/scripts/on_cron_update.sh") | crontab -
