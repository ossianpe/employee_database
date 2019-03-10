#
# Cookbook:: employee_database
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

db_host='192.168.0.10'
remote_mysql_user=node['employee_database']['database']['mysql']['remote_username']
remote_mysql_password=node['employee_database']['database']['mysql']['remote_password']

# Build cmd for connecting to mysql shell
init_remote_connection=init_remote_mysql_connection(db_host, remote_mysql_user, remote_mysql_password)

mysql_client_installation_package 'default' do
    version '5.7'
    action :create
end

execute 'set remote mysql privileges' do
  command <<-"SQL"
      #{init_remote_connection} -e "\
            SELECT * FROM employees \
            WHERE gender = "M" \
            AND birth_date = "1965-02-01" \
            AND hire_date > "1990-01-01" \
            ORDER BY last_name, first_name DESC;
  SQL
  user 'root'
  action :run
end
  
template 'index.html' do
    path   '/usr/share/nginx/html/index.html'
    source 'index.html.erb'
    mode '0644'
    variables({
      servername: node['hostname']
    })
end