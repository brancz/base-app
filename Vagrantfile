# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"
  config.vm.synced_folder "./", "/home/vagrant/app"
  config.vm.synced_folder "saltstack/salt", "/srv/salt"

  config.vm.network :forwarded_port, host: 5000, guest: 5000

  config.vm.provision :salt do |salt|
    salt.minion_config = "saltstack/minion"
    salt.run_highstate = true
    salt.verbose = true
  end
end
