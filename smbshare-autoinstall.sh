#!/bin/bash

# Color codes
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
RED="\e[31m"
NC="\e[0m" # No Color

# Prompt user for input
echo -e "${YELLOW}Enter the path for the share (default: /srv/sambashare):${NC}"
read -r SHARE_PATH
SHARE_PATH=${SHARE_PATH:-/srv/sambashare}
echo -e "${YELLOW}Enter the Samba username:${NC}"
read -r SMB_USER
echo -e "${YELLOW}Enter the Samba password:${NC}"
read -sr SMB_PASSWORD
CONFIG_PATH="/etc/samba/smb.conf"

# Update package list and install Samba if not installed
if ! command -v smbd &> /dev/null; then
    echo -e "${YELLOW}Installing Samba...${NC}"
    apt update -qq >/dev/null 2>&1 && apt install -y samba >/dev/null 2>&1
else
    echo -e "${GREEN}Samba is already installed.${NC}"
fi

# Create the shared directory if it doesn't exist
if [ ! -d "$SHARE_PATH" ]; then
    mkdir -p "$SHARE_PATH"
    chmod 777 "$SHARE_PATH"
    chown nobody:nogroup "$SHARE_PATH"
    echo -e "${BLUE}Created shared directory at $SHARE_PATH${NC}"
else
    echo -e "${YELLOW}Shared directory already exists.${NC}"
fi

# Create system user if not exists
if ! id "$SMB_USER" &>/dev/null; then
    useradd -M -s /sbin/nologin "$SMB_USER" >/dev/null 2>&1
    echo -e "${GREEN}System user $SMB_USER created.${NC}"
else
    echo -e "${YELLOW}System user $SMB_USER already exists.${NC}"
fi

# Set Samba password for the user
echo -e "$SMB_PASSWORD\n$SMB_PASSWORD" | smbpasswd -s -a "$SMB_USER" >/dev/null 2>&1
smbpasswd -e "$SMB_USER" >/dev/null 2>&1

# Check if the Samba configuration already contains the share
grep -q "\[sambashare\]" "$CONFIG_PATH" || echo "
[sambashare]
   path = $SHARE_PATH
   browseable = yes
   read only = no
   guest ok = no
   valid users = $SMB_USER
   force user = $SMB_USER
   create mask = 0666
   directory mask = 0777
" >> "$CONFIG_PATH"

echo -e "${GREEN}Samba configuration updated.${NC}"

# Restart and enable Samba services
systemctl restart smbd nmbd >/dev/null 2>&1
systemctl enable smbd nmbd >/dev/null 2>&1

# Output completion message
echo -e "${GREEN}Samba share has been set up successfully: ${BLUE}//$HOSTNAME/sambashare${NC}"
