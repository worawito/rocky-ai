#!/bin/bash

# Script to automate Rocky Linux 9.5 installation using Kickstart

# Variables
KICKSTART_LOCATION="" # Location of the Kickstart file
ISO_DEVICE="" # Device containing the Rocky Linux 9.5 ISO (e.g., /dev/sdb, /dev/vda)
HTTP_SERVER="" # IP address or hostname of the HTTP server for Kickstart

# Function to display usage information
usage() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  -c <path>  Path to the Kickstart file (local or HTTP)"
  echo "  -i <device> Device containing the Rocky Linux 9.5 ISO"
  echo "  -h <server> HTTP server address for Kickstart file"
  echo "  -h           Display this help message"
  exit 1
}

# Parse command-line options
while getopts "c:i:h:" opt; do
  case "$opt" in
    c)
      KICKSTART_LOCATION="$OPTARG"
      ;;
    i)
      ISO_DEVICE="$OPTARG"
      ;;
    h)
      HTTP_SERVER="$OPTARG"
      ;;
    \?)
      usage
      ;;
  esac
done

# Check if Kickstart location is provided
if [ -z "$KICKSTART_LOCATION" ]; then
  echo "Error: Kickstart file location must be specified."
  usage
fi

# Determine the Kickstart method
if [[ "$KICKSTART_LOCATION" == http* ]]; then
  # HTTP Kickstart
  KICKSTART_METHOD="http"
  KICKSTART_URL="$KICKSTART_LOCATION"
elif [ -f "$KICKSTART_LOCATION" ]; then
  # Local Kickstart
  KICKSTART_METHOD="local"
  KICKSTART_PATH="$KICKSTART_LOCATION"
else
  echo "Error: Invalid Kickstart location."
  usage
fi

# Determine ISO device
if [ -n "$ISO_DEVICE" ]; then
  BOOT_OPTIONS="inst.stage2=hd:$ISO_DEVICE inst.ks="
else
  BOOT_OPTIONS="inst.ks="
fi

# Construct the boot options
if [ "$KICKSTART_METHOD" == "http" ]; then
  BOOT_OPTIONS="$BOOT_OPTIONS$KICKSTART_URL"
elif [ "$KICKSTART_METHOD" == "local" ]; then
    if [ -n "$ISO_DEVICE" ]; then
        #find the partition that contains the kickstart.
        PART_NUMBER=$(blkid | grep "$ISO_DEVICE" | awk '{print $1}' | sed 's/://' | sed 's/\/dev\///g' | sed 's/[a-z]*//g')
        BOOT_OPTIONS="$BOOT_OPTIONS$ISO_DEVICE$PART_NUMBER:/$KICKSTART_PATH"
    else
        echo "Error: ISO device must be provided when using local kickstart file."
        usage
    fi
fi

# Display the boot options
echo "Boot options: $BOOT_OPTIONS"

# Example: Using grub-install to automate the boot process (Requires root privileges)
# Note: This part is highly dependent on your environment.
# You might need to adjust the device and other parameters.
# For example, if you are booting a VM, you may not need to run grub-install.
# It is also possible that this script is run from the grub prompt itself, in which case, this part would be omitted.

# example.
# grub-install --boot-directory=/mnt/boot /dev/sda
# echo "Bootloader installed."

# Example: Running the installation (This step needs to be done manually, or via a hypervisor API)
# This script would be run from the grub prompt, so you would manually type the boot options above.
# echo "Starting installation..."
# echo "Installation complete."

# Example of how to use this script.
# ./install.sh -c /path/to/kickstart.cfg -i /dev/sdb
# ./install.sh -c http://192.168.1.10/kickstart.cfg
