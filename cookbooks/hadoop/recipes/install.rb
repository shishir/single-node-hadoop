remote_file "#{node.hadoop.download_dir}/hadoop-#{node.hadoop.version}.tar.gz" do
  source node.hadoop.mirror_url
  action :create_if_missing
end

execute "unpack hadoop" do
  command "tar  -C #{node.hadoop.user_home} -xf #{node.hadoop.download_dir}/hadoop-#{node.hadoop.version}.tar.gz"
  not_if {::File.exists?("#{node.hadoop.download_dir}/hadoop-1.2.0")}
end
