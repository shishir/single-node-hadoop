group node.hadoop.user_group_name do
end

user node.hadoop.user do
  home node.hadoop.user_home
  gid  node.hadoop.user_group_name
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

execute "create ssh key for #{node.hadoop.user}" do
  command "mkdir #{node.hadoop.user_home}/.ssh && ssh-keygen -f #{node.hadoop.user_home}/.ssh/id_rsa -P ''"
  cwd node.hadoop.user_home
  user node.hadoop.user
  not_if {::File.exists?("#{node.hadoop.user_home}/.ssh/id_rsa")}
end

execute "allow ssh access for local machine" do
  command "cat #{node.hadoop.user_home}/.ssh/id_rsa.pub >> #{node.hadoop.user_home}/.ssh/authorized_keys"
  cwd node.hadoop.user_home
  user node.hadoop.user
  not_if {::File.exists?("#{node.hadoop.user_home}/.ssh/authorized_keys")}
end

execute "transfer ownership to hduser" do
  command "chown -R #{node.hadoop.user}:#{node.hadoop.user_group_name} #{node.hadoop.user_home}"
end