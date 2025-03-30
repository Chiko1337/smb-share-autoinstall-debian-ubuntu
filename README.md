# SMB Share Setup Script

This script automates the installation and configuration of an SMB share on a Debian 12 server. It installs Samba, creates a shared directory, sets appropriate permissions, and configures a Samba user.

## Features
- Installs Samba if not already installed.
- Creates a shared directory.
- Sets permissions for the shared directory.
- Creates a Samba user and sets a password.
- Configures Samba to allow authenticated access to the share.
- Restarts the Samba service to apply changes.

## Usage

1. Clone or download the script to your Debian 12 server.
   ```bash
   wget https://raw.githubusercontent.com/Chiko1337/smb-share-autoinstall-debian-ubuntu/refs/heads/main/smbshare-autoinstall.sh
   ```
2. Make the script executable:
   ```bash
   sed -i 's/\r$//' smbshare-autoinstall.sh
   chmod +x smbshare-autoinstall.sh
   ```
3. Run the script with sudo:
   ```bash
   sudo bash smbshare-autoinstall.sh
   ```
4. Follow the script to set the variables:
   - `SHARE_PATH`: Path of the shared directory.
   - `SMB_USER`: Samba username.
   - `SMB_PASSWORD`: Samba user password.

## Notes
- The script sets permissions to allow the specified user full access.
- The script enables Samba to start on boot.

## License
This script is released under the MIT License.

