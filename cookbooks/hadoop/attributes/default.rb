node.default[:hadoop]                   = {}
node.default[:hadoop][:version]         = "1.2.0"
node.default[:hadoop][:mirror_url]      = "http://apache.mirrors.tds.net/hadoop/common/hadoop-#{node.default[:hadoop][:version]}/hadoop-#{node.default[:hadoop][:version]}.tar.gz"
node.default[:hadoop][:download_dir]    = "/tmp"
node.default[:hadoop][:user]            = "hduser"
node.default[:hadoop][:user_home]       = "/home/#{node.hadoop.user}"
node.default[:hadoop][:user_group_name] = "hadoop"
node.default[:hadoop][:data_dir]        = "#{node.hadoop.user_home}/app/hadoop/tmp"
