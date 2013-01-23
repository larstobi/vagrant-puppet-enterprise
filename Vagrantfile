Vagrant::Config.run do |config|
  config.vm.customize ['modifyvm', :id, '--cpus', '3']
  config.vm.customize ['modifyvm', :id, '--memory', '2048']
  config.vm.customize ['modifyvm', :id, '--chipset', 'ich9']
  config.vm.customize ['modifyvm', :id, '--nictype1', 'virtio']

  # If the disk is on a Solid State Drive
  config.vm.customize ['storageattach', :id, '--storagectl', 'SATA Controller',
                       '--port', '0', '--nonrotational', 'on']

  config.vm.box = "ubuntu-12.04-server-amd64"
  config.vm.box_url = "https://s3-eu-west-1.amazonaws.com/vagrantbox.es/ubuntu-12.04-server-amd64.box"

  # Speed up installing packages by copying over *.deb packages from local cache.
  # This avoids downloading them each time you destroy your vagrant box.
  # Create a dir called "aptcache" in the same directory as Vagrantfile and populate
  # it with the deb-packages from /var/cache/apt/archives/ after all your
  # packages have been installed.
  #
  # rsync_aptcache = '/usr/bin/rsync -aq /vagrant/aptcache/ /var/cache/apt/archives/'
  # config.vm.provision :shell, :inline => rsync_aptcache

  apt_update = 'if [ ! -f /tmp/apt_updated ]; then ' +
                'apt-get update && ' +
                'touch /tmp/apt_updated ; fi'
  config.vm.provision :shell, :inline => apt_update

  pe_version = '2.7.0'
  pe_src = "puppet-enterprise-#{pe_version}-ubuntu-12.04-amd64"
  pe_url = "https://s3-eu-west-1.amazonaws.com/puppet.xdct.net/#{pe_src}.tar.gz"

  pe_install = "/vagrant/bin/pe-install.sh #{pe_src} #{pe_url}"
  config.vm.provision :shell, :inline => pe_install

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.module_path = "modules"
    puppet.options = "--show_diff --verbose --debug --environment=vagrant"
  end
end
