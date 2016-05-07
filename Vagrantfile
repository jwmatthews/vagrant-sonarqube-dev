# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.hostname = "sonar.example.com"
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  config.vm.provision :shell, :path => "setup.sh"
  config.vm.network "private_network", type: "dhcp"
  config.vm.network "forwarded_port", guest: 9000, host: 9000
  config.ssh.insert_key = false

  config.vm.provider :libvirt do |libvirt, override|
    libvirt.driver = "kvm"
    libvirt.memory = 4096
    libvirt.cpus = 2
    override.vm.synced_folder ".", "/vagrant", type: "nfs"
  end

  config.vm.provider :virtualbox do |vbox, override|
    vbox.memory = 4096
    vbox.cpus = 2
    vbox.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vbox.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    override.vm.box = "centos-7.2_20160506"
    override.vm.box_url = "https://s3.amazonaws.com/fusor-vagrant/centos-7.2_20160506.virtualbox.box"
    override.vm.synced_folder ".", "/vagrant"
  end

end
