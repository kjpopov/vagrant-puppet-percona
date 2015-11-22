# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    # Display the VirtualBox GUI when booting the machine
    # vb.gui = true
    # Customize the amount of memory on the VM:
    vb.memory = "1536"
  end

  config.vm.provision "shell", inline: <<-SHELL
    # Install Percona Server
    if [ $(dpkg-query -W -f='${Status}' percona-server-server-5.6 2>/dev/null | grep -c "ok installed") -eq 0 ];
    then
    sudo apt-key adv --keyserver keys.gnupg.net --recv-keys 1C4CBDCDCD2EFD2A
    sudo bash -c 'echo deb http://repo.percona.com/apt trusty main >> /etc/apt/sources.list'
    sudo bash -c 'echo deb-src http://repo.percona.com/apt trusty main >> /etc/apt/sources.list'
    sudo apt-get update
    echo "percona-server-server-5.6 percona-server-server/root_password password root" | sudo debconf-set-selections
    echo "percona-server-server-5.6 percona-server-server/root_password_again password root" | sudo debconf-set-selections
    sudo apt-get install -qq -y percona-server-server-5.6 percona-server-client-5.6
    # Ensure that all packages are up to date
    sudo apt-get upgrade -y
    fi
  SHELL

  config.vm.define "pdb1" do |pdb1|
    pdb1.vm.box = "Ubuntu1404DailyCloud"
    pdb1.vm.hostname = "pdb1"
    pdb1.vm.network "private_network", ip: "10.0.5.55"
    pdb1.vm.provision "puppet" do |puppet|
      puppet.module_path = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "pdb1.pp"
      puppet.options = "--verbose --show_diff"
    end
  end

  config.vm.define "pdb2" do |pdb2|
    pdb2.vm.box = "Ubuntu1404DailyCloud"
    pdb2.vm.hostname = "pdb2"
    pdb2.vm.network "private_network", ip: "10.0.5.56"
    pdb2.vm.provision "puppet" do |puppet|
      puppet.module_path = "puppet/modules"
      puppet.manifests_path = "puppet/manifests"
      puppet.manifest_file = "pdb2.pp"
      puppet.options = "--verbose --show_diff"
    end
  end
  
end
