# Distrobox Update Service

This service automatically updates all Distrobox instances and their exported applications on a daily basis.

## Components

1. `distrobox-update.sh`: A bash script that performs the update process.
2. `distrobox-update.service`: A systemd service file to manage the update script.

## Installation

### 1. Install the update script

```bash
sudo nano /usr/local/bin/distrobox-update.sh
```

Paste the script content into this file, then save and exit.

Make the script executable:

```bash
sudo chmod +x /usr/local/bin/distrobox-update.sh
```

### 2. Create the systemd service file

```bash
sudo nano /etc/systemd/system/distrobox-update.service
```

Paste the service file content into this file. Replace `YOUR_USERNAME` with your actual username, then save and exit.

### 3. Reload systemd

```bash
sudo systemctl daemon-reload
```

### 4. Enable the service

```bash
sudo systemctl enable distrobox-update.service
```

### 5. Start the service

```bash
sudo systemctl start distrobox-update.service
```

## Usage

The service will run automatically once per day. You can manage it using standard systemd commands:

- Check status: `sudo systemctl status distrobox-update.service`
- Stop the service: `sudo systemctl stop distrobox-update.service`
- Start the service: `sudo systemctl start distrobox-update.service`
- Restart the service: `sudo systemctl restart distrobox-update.service`
- Disable the service: `sudo systemctl disable distrobox-update.service`

## Logs

You can view the logs of the update process using the journalctl command:

```bash
sudo journalctl -u distrobox-update.service
```

## Customization

If you need to modify the update frequency or add more functionality, edit the `/usr/local/bin/distrobox-update.sh` file. Remember to restart the service after making changes:

```bash
sudo systemctl restart distrobox-update.service
```

## Troubleshooting

If you encounter any issues:

1. Check the service status and logs using the commands mentioned above.
2. Ensure that the script has the correct permissions and is executable.
3. Verify that the paths in the service file are correct.
4. Make sure your user has the necessary permissions to run Distrobox commands.

## Uninstallation

To remove the service:

1. Stop and disable the service:
   ```bash
   sudo systemctl stop distrobox-update.service
   sudo systemctl disable distrobox-update.service
   ```

2. Remove the service file:
   ```bash
   sudo rm /etc/systemd/system/distrobox-update.service
   ```

3. Remove the script:
   ```bash
   sudo rm /usr/local/bin/distrobox-update.sh
   ```

4. Reload systemd:
   ```bash
   sudo systemctl daemon-reload
   ```

## Support

If you need further assistance, please open an issue in the project repository or contact the maintainer.
