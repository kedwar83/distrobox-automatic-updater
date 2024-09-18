#!/bin/bash

# Function to log messages
log() {
    echo "[$(date +'%Y-%m-%d %H:%M:%S')] $1"
}

# Function to update a single Distrobox instance
update_distrobox() {
    local instance="$1"
    log "Updating Distrobox instance: $instance"
    distrobox enter "$instance" -- sudo apt update && sudo apt upgrade -y
    if [ $? -eq 0 ]; then
        log "Successfully updated $instance"
    else
        log "Failed to update $instance"
    fi
}

# Function to update exported applications for a Distrobox instance
update_exported_apps() {
    local instance="$1"
    log "Updating exported applications for: $instance"
    distrobox enter "$instance" -- distrobox-export --app ALL
    if [ $? -eq 0 ]; then
        log "Successfully updated exported applications for $instance"
    else
        log "Failed to update exported applications for $instance"
    fi
}

# Main function to update all Distrobox instances and exported applications
update_all() {
    log "Starting update process for all Distrobox instances and exported applications"

    # Get list of Distrobox instances
    instances=$(distrobox list --no-color | tail -n +2 | awk '{print $2}')

    # Update each instance and its exported applications
    for instance in $instances; do
        update_distrobox "$instance"
        update_exported_apps "$instance"
    done

    log "Update process completed"
}

# Run the main function
update_all

# Sleep for a day before running again
sleep 1d
