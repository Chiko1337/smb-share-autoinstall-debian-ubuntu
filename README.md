# SMB Share Setup Script

This script automates the installation and configuration of an SMB share on a Debian 12 server. It installs Samba, creates a shared directory, sets appropriate permissions, and configures a Samba user.

## Features
- Installs Samba if not already installed.
- Creates a shared directory at `/srv/smbshare`.
- Sets permissions for the shared directory.
- Creates a Samba user and sets a password.
- Configures Samba to allow authenticated access to the share.
- Restarts the Samba service to apply changes.

## Usage

1. Clone or download the script to your Debian 12 server.
   ```bash
   wget https://raw.githubusercontent.com/Chiko1337/smb-share-autoinstall-debian-ubuntu/refs/heads/main/smbshare-autoinstall.sh
   ```
2. Modify the variables at the beginning of the script if needed:
   ```bash
   nano smbshare-autoinstall.sh
   ```
   - `SHARE_NAME`: Name of the SMB share.
   - `SHARE_PATH`: Path of the shared directory.
   - `SMB_USER`: Samba username.
   - `SMB_PASSWORD`: Samba user password.
3. Make the script executable:
   ```bash
   chmod +x smbshare-autoinstall.sh
   ```
4. Run the script with sudo:
   ```bash
   sudo bash ./smbshare-autoinstall.sh
   ```

## Notes
- The script sets permissions to allow the specified user full access.
- The default Samba user password is `Passwort123`, change it for security reasons.
- The script enables Samba to start on boot.

## License
This script is released under the MIT License.

