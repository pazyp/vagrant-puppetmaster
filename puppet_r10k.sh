#!/usr/bin/env bash
#
# This installs r10k and pulls the modules for continued installation
#
# We cannot handle failures gracefully here
set -e

if [ "$EUID" -ne "0" ]; then
  echo "This script must be run as root." >&2
  exit 1
fi
export DEBIAN_FRONTEND=noninteractive

apt-get update >/dev/null

echo "Installing ruby 2.7 ..."
apt-get install -y ruby ruby-dev \
	rubygems \
	build-essential libssl-dev zlib1g-dev >/dev/null
	
echo "Installing git..."
apt-get install -y git >/dev/null

#update-alternatives --set ruby /usr/bin/ruby
#update-alternatives --set gem /usr/bin/gem


echo "Installing r10k..."
gem install r10k >/dev/null

echo "Running r10k to fetch modules for puppet provisioner..."
cp /vagrant/VagrantConf/Puppetfile .
r10k puppetfile install
