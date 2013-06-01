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

execute "unpack hadoop" do
  command "tar  -C #{node.hadoop.user_home} -xf #{node.hadoop.download_dir}/hadoop-1.2.0.tar.gz"
  not_if {::File.exists?("#{node.hadoop.download_dir}/hadoop-1.2.0")}
end

execute "transfer ownership to hduser" do
  command "chown -R #{node.hadoop.user}:#{node.hadoop.user_group_name} #{node.hadoop.user_home}"
end

execute "append java home to hadoop setenv.sh" do
  command %Q{echo "export JAVA_HOME=$JAVA_HOME" >> "#{node.hadoop.user_home}/hadoop-1.2.0/conf/hadoop-env.sh"}
  user node.hadoop.user
end

execute "create directory through execute, coz chef is stupid with permission on recursive" do
  command "mkdir -p #{node.hadoop.data_dir}"
  user node.hadoop.user
  group node.hadoop.user_group_name
  not_if {::File.exists?("#{node.hadoop.data_dir}")}
end

template "#{node.hadoop.user_home}/hadoop-1.2.0/conf/core-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
  variables :data_dir => node.hadoop.data_dir
end

template "#{node.hadoop.user_home}/hadoop-1.2.0/conf/mapred-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end

template "#{node.hadoop.user_home}/hadoop-1.2.0/conf/hdfs-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end



