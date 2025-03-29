#!/bin/bash

# Variables
SHARE_NAME="smbshare"
SHARE_PATH="/srv/$SHARE_NAME"
SMB_USER="smbuser"
SMB_PASSWORD="!!ChangeMe!!"
CONFIG_PATH="/etc/samba/smb.conf"

# Update and installation of Samba
apt update && apt install -y samba

# Create directory
mkdir -p "$SHARE_PATH"
chmod 777 "$SHARE_PATH"
chown nobody:nogroup "$SHARE_PATH"

# Create Samba user
useradd -M -s /sbin/nologin "$SMB_USER" || echo "Benutzer bereits vorhanden"
echo -e "$SMB_PASSWORD\n$SMB_PASSWORD" | smbpasswd -a "$SMB_USER"
smbpasswd -e "$SMB_USER"

# Customize Samba configuration
echo "
[$SHARE_NAME]
   path = $SHARE_PATH
   browseable = yes
   read only = no
   guest ok = no
   valid users = $SMB_USER
   force user = $SMB_USER
   create mask = 0666
   directory mask = 0777
" >> "$CONFIG_PATH"

# Restart Samba service
systemctl restart smbd
systemctl enable smbd

# Finished
echo "SMB share has been set up successfully: //$HOSTNAME/$SHARE_NAME"
