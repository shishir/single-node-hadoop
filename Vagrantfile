# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  config.vm.box = "precise64"
  config.vm.forward_port 50030, 51130
  config.vm.provision :shell, :inline => "sudo apt-get update"
  config.vm.provision :chef_solo do |chef|
   chef.cookbooks_path = "cookbooks"
   chef.add_recipe 'java'
   chef.add_recipe 'hadoop'
  end
end
