#
# Cookbook:: employee_database
# Recipe:: lb
#
# Copyright:: 2019, The Authors, All Rights Reserved.

unused_configs=node['employee_database']['lb']['config_to_remove']
app_nodes=node['employee_database']['lb']['app_nodes']

unused_configs.each do |configs|
  file configs do
    action :delete
  end
end

template 'load-balancer.conf' do
  path   "#{node['nginx']['dir']}/conf.d/load-balancer.conf"
  source 'load-balancer.conf.erb'
  notifies :reload, 'service[nginx]', :delayed
  mode '0644'
  variables({
    app_nodes: node['employee_database']['lb']['app_nodes']
  })
end