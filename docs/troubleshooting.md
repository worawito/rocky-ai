
# Rocky Linux 9.5 Installation Troubleshooting

## Common Issues

* **Network Issues:**
    * Verify network connectivity.
    * Check DNS settings.
* **Partitioning Errors:**
    * Double-check partition sizes and mount points.
    * Verify drive selection.
* **Kickstart Errors:**
    * Check for syntax errors in your kickstart.cfg.
    * Verify the kickstart file is accessible.
* **Boot Errors:**
    * Verify the ISO integrity.
    * Check BIOS/UEFI settings.

## Solutions

* **Network:**
    * Use `ip addr` and `ping` to debug connectivity.
    * Check `/etc/resolv.conf` for DNS.
* **Partitions:**
    * Use `fdisk` or `parted` to examine partitions.
* **Kickstart:**
    * Use `ksvalidator` to validate the kickstart file.
    * View the installer logs for errors.
* **Boot:**
    * Re-download the ISO and verify checksums.
    * Ensure boot order is correct in BIOS/UEFI.
