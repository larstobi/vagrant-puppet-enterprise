#!/bin/bash
pe_src=$1
pe_url=$2
echo $pe_src $pe_url

# Run PE-installer unless already installed
if [ ! -f /opt/puppet/bin/puppet ]; then

  # Unpack PE tarball, download if not exists
  if [ ! -d /tmp/${pe_src} ]; then
    if [ ! -f /vagrant/${pe_src}.tar.gz ]; then
      wget -P /vagrant/ ${pe_url}
    fi
    tar zxf /vagrant/${pe_src}.tar.gz -C /tmp/
  fi

  /tmp/${pe_src}/puppet-enterprise-installer -A /vagrant/answers.txt
  rm -rf /tmp/${pe_src}/puppet-enterprise-installer
fi
