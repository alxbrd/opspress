# OpsPress

Centos 7 VirtualBox installation with vagrant.

The box is provisioned using Puppet or Ansible.

By default Ansible is configured as a provisioner in the Vagrantfile.

Wordpress is installed using WP-CLI.

### How to run

  - Ensure you have vagrant installed. http://www.vagrantup.com
  - Ensure you have vagrant host updater plugin installed:
    `vagrant plugin install vagrant-hostupdater`
  - For the ansible provisioner, install Ansible
  
### To do
  - Use Hiera configs for Puppet
  - Abstract variables for Ansible
  - Install phpmyadmin
