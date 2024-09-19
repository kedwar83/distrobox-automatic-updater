# Distrobox Automatic Update Service

This service automatically runs `distrobox-upgrade --all` once a day to keep all your Distrobox containers up to date.

## Prerequisites

- A Linux system using systemd
- Distrobox installed and configured
- sudo privileges

## Installation

1. Create the service file:

   ```bash
   sudo vim /etc/systemd/system/distrobox-upgrade.service
   ```

   Copy and paste the following content:

   ```ini
   [Unit]
   Description=Distrobox Upgrade Service
   After=network.target

   [Service]
   Type=oneshot
   ExecStart=/usr/bin/distrobox-upgrade --all
   User=YOUR_USERNAME

   [Install]
   WantedBy=multi-user.target
   ```

   Replace `YOUR_USERNAME` with your actual username.

2. Create the timer file:

   ```bash
   sudo vim /etc/systemd/system/distrobox-upgrade.timer
   ```

   Copy and paste the following content:

   ```ini
   [Unit]
   Description=Run Distrobox Upgrade daily

   [Timer]
   OnCalendar=daily
   Persistent=true

   [Install]
   WantedBy=timers.target
   ```

3. Reload systemd, enable and start the timer:

   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable distrobox-upgrade.timer
   sudo systemctl start distrobox-upgrade.timer
   ```

## Verification

To verify that the service is set up correctly:

1. Check the status of the timer:

   ```bash
   sudo systemctl status distrobox-upgrade.timer
   ```

2. List all timers:

   ```bash
   sudo systemctl list-timers
   ```

   You should see `distrobox-upgrade.timer` in the list.

## Customization

- To change the frequency of updates, modify the `OnCalendar` value in the `distrobox-upgrade.timer` file. For example, to run weekly instead of daily, use `OnCalendar=weekly`.
- To run the upgrade at a specific time, use a value like `OnCalendar=*-*-* 02:00:00` (this would run it at 2 AM every day).

## Troubleshooting

- Check the system logs for any error messages:

  ```bash
  journalctl -u distrobox-upgrade.service
  ```

- Ensure that the user specified in the service file has the necessary permissions to run `distrobox-upgrade --all`.

## Uninstallation

To remove the service:

1. Stop and disable the timer:

   ```bash
   sudo systemctl stop distrobox-upgrade.timer
   sudo systemctl disable distrobox-upgrade.timer
   ```

2. Remove the service and timer files:

   ```bash
   sudo rm /etc/systemd/system/distrobox-upgrade.service
   sudo rm /etc/systemd/system/distrobox-upgrade.timer
   ```

3. Reload systemd:

   ```bash
   sudo systemctl daemon-reload
   ```
