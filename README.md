## Hadoop on Vagrant

Allows to create a instance on virtual box with single node hadoop configured. It relies on vagrant for provisioning. 
This setup is tested on ubuntu(precise64) box.



## Setup
  
### Download the vagrant box file.
  $ wget http://files.vagrantup.com/precise64.box

### Add box to vagrant. 
 
box name is precise64 in the VagrantFile. If want a different name, make sure you update the Vagrant file.

  $ vagrant box add precise64 <local file path>

### Provision box

   $ vagrant up


## Attributes for hadoop







