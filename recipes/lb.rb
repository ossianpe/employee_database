#
# Cookbook:: employee_database
# Recipe:: lb
#
# Copyright:: 2019, The Authors, All Rights Reserved.

unused_configs=node['employee_database']['lb']['config_to_remove']
app_node_list=[]

# Determine all app nodes to add to nginx configuration
discovered_nodes=endpoint_search(node, 'role:app')
discovered_nodes.each do |app_node|
  app_node_list.push(app_node.attributes['ipaddress'])
end

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
    app_nodes: app_node_list
  })
end