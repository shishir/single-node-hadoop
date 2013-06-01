remote_file "#{node.hadoop.download_dir}/hadoop-1.2.0.tar.gz" do
  source node.hadoop.mirror_url
  action :create_if_missing
end

group node.hadoop.user_group_name do
end

user node.hadoop.user do
  home node.hadoop.user_home
  gid  node.hadoop.user_group_name
  shell "/bin/bash"
  supports :manage_home => true
  action :create
end

execute "Create Ssh key for #{node.hadoop.user}" do
  command "mkdir .ssh && ssh-keygen -f .ssh/id_rsa -P """
  user node.hadoop.user
  not_if {::File.exists?(".ssh/id_rsa")}
end

execute "unpack hadoop" do
  command "tar  -C #{node.hadoop.user_home} -xf #{node.hadoop.download_dir}/hadoop-1.2.0.tar.gz"
  not_if {::File.exists?("#{node.hadoop.download_dir}/hadoop-1.2.0")}
end

execute "transfer ownership to hduser" do
  command "chown -R #{node.hadoop.user}:#{node.hadoop.user_group_name} #{node.hadoop.user_home}"
end
