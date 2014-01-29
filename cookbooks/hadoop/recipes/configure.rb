execute "append java home to hadoop setenv.sh" do
  command %Q{echo "export JAVA_HOME=$JAVA_HOME" >> "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/hadoop-env.sh"}
  user node.hadoop.user
end

execute "create directory through execute, coz chef is stupid with permission on recursive" do
  command "mkdir -p #{node.hadoop.data_dir}"
  user node.hadoop.user
  group node.hadoop.user_group_name
  not_if {::File.exists?("#{node.hadoop.data_dir}")}
end

template "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/core-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
  variables :data_dir => node.hadoop.data_dir
end

template "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/mapred-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end

template "#{node.hadoop.user_home}/hadoop-#{node.hadoop.version}/conf/hdfs-site.xml" do
  owner node.hadoop.user
  group node.hadoop.user_group_name
  mode 0664
end