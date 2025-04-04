#!/bin/bash
# Example post-installation script
echo "Running post-installation tasks..."
# Add your post-installation commands here
yum -y update
yum -y install vim
echo "Post-installation tasks completed."
