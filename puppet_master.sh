#!/usr/bin/env bash
#
# This bootstraps Puppet on Ubuntu 20.04 LTS (Focal Fossa).
#
set -e

REPO_DEB_URL="https://apt.puppet.com/puppet7-release-focal.deb"
export DEBIAN_FRONTEND=noninteractive

#--------------------------------------------------------------------
# NO TUNABLES BELOW THIS POINT
#--------------------------------------------------------------------
if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi

# Install the PuppetLabs repo
echo "Configuring PuppetLabs repo..."
curl -O ${REPO_DEB_URL} > /dev/null 2>&1
dpkg -i puppet7-release-focal.deb > /dev/null 2>&1
apt-get update > /dev/null 2>&1

# Install Puppet
echo "Installing Puppet..."
apt-get install -y puppetserver > /dev/null 2>&1

echo "Puppet installed!"