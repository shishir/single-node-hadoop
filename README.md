single-node-hadoop
==================

Vagrant setup for single node hadoop cluster.


Steps
============================
* Download precise box file from (https://s3-us-west-2.amazonaws.com/squishy.vagrant-boxes/precise64_squishy_2013-02-09.box)
* vagrant box add precise64 <local file path>
* vagrant up
** if it fails. try and do 'sudo apt-get update' inside vagrant box. And run vagrant provision.






