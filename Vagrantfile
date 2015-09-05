# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "puppetlabs/centos-7.0-64-puppet"

  config.vm.box_version = "1.0.2"

  config.vm.provision :shell, path: "files/scripts/setup.sh"

  # Configure hostnames using the hostupdater plugin
  config.vm.hostname = "opspress.dev"
  config.vm.network :private_network, :ip => "192.168.50.10", :auto_config => true
  #config.vm.network "forwarded_port", guest: 80, host: 8080

  config.hostsupdater.aliases = %w{www.opspress.dev}
  config.hostsupdater.remove_on_suspend = true

  config.vm.synced_folder "src/", "/var/app/current"

  # Set the path to ansible.cfg
  ENV['ANSIBLE_CONFIG'] = "./provisioning/ansible/ansible.cfg"

  config.vm.provision :ansible do |ansible|
    ansible.playbook = "provisioning/ansible/playbook.yml"
    ansible.host_key_checking = "false"
    ansible.inventory_path = "provisioning/ansible/hosts"
    ansible.raw_arguments = ["--connection=ssh"]
    ansible.groups = {
        "wordpress" => ["vm"]
    }
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
  end
end
