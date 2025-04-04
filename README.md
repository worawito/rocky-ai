# rocky-ai
This repo for my install Ollama on rocky linux .
# Rocky Linux 9.5 Installation Guide

This repository provides scripts and configuration files to assist with the installation of Rocky Linux 9.5.

## Table of Contents

* [Prerequisites](#prerequisites)
* [Installation Methods](#installation-methods)
* [Kickstart Installation (Automated)](#kickstart-installation-automated)
* [Manual Installation](#manual-installation)
* [Scripts](#scripts)
* [Troubleshooting](#troubleshooting)
* [Contributing](#contributing)

## Prerequisites

* A machine (physical or virtual) capable of running Rocky Linux 9.5.
* Rocky Linux 9.5 ISO image.
* Bootable USB drive or virtual machine environment.
* Network connectivity (if required for online repositories).

## Installation Methods

This guide covers both automated (Kickstart) and manual installations.

## Kickstart Installation (Automated)

Kickstart installation allows for automated and unattended installations of Rocky Linux.

1.  **Kickstart Configuration (kickstart.cfg):**
    * Place your Kickstart configuration file (`kickstart.cfg`) in the `config` directory.
    * Example basic kickstart.cfg:

    ```
    install
    text
    cdrom
    lang en_US.UTF-8
    keyboard us
    timezone America/New_York
    rootpw --iscrypted $6$EXAMPLE$EXAMPLE
    auth --enableshadow --passalgo=sha512
    selinux --enforcing
    firewall --enabled --ssh
    bootloader --location=mbr --boot-drive=sda
    clearpart --all --initlabel
    part /boot --fstype="xfs" --size=1024
    part swap --size=2048
    part / --fstype="xfs" --grow --size=1
    %packages
    @^minimal-environment
    %end
    %post
    # Post-installation commands
    %end
    ```

2.  **Booting with Kickstart:**
    * Boot from the Rocky Linux 9.5 ISO.
    * At the boot prompt, add the `inst.ks=cdrom:/kickstart.cfg` option (if the kickstart file is on the ISO) or `inst.ks=http://YOUR_SERVER/kickstart.cfg` (if the kickstart file is on a web server).

## Manual Installation

1.  **Boot from the ISO:**
    * Boot from the Rocky Linux 9.5 ISO.
2.  **Follow the Installer:**
    * Follow the on-screen instructions to configure the installation.
3.  **Partitioning:**
    * Manually partition your drives as needed.
4.  **Package Selection:**
    * Select the desired software packages.
5.  **Complete Installation:**
    * Finish the installation and reboot.

## Scripts

The `scripts` directory contains optional scripts to automate pre- and post-installation tasks.

* **pre-install.sh:**
    * Scripts to run before the installation process.
    * Example: Setting up network configurations.
* **install.sh:**
    * A script that can be used to run the installation from a command line, or to automate certain steps.
* **post-install.sh:**
    * Scripts to run after the installation is complete.
    * Example: Installing additional software, configuring services.

## Troubleshooting

Refer to the `docs/troubleshooting.md` file for common installation issues and solutions.

## Contributing

Contributions are welcome! Please submit pull requests with improvements or fixes.
