#
# Cookbook:: employee_database
# Recipe:: app
#
# Copyright:: 2019, The Authors, All Rights Reserved.

db_host='192.168.0.10'
remote_mysql_user=node['employee_database']['database']['mysql']['remote_username']
remote_mysql_password=node['employee_database']['database']['mysql']['remote_password']
query_output_file=node['employee_database']['database']['mysql']['query_output_file']
nginx_web_hosting_path='/usr/share/nginx/html/'

# Build cmd for connecting to mysql shell
init_remote_connection=init_remote_mysql_connection(db_host, remote_mysql_user, remote_mysql_password)

mysql_client_installation_package 'default' do
  version '5.7'
  action :create
end

execute 'set remote mysql privileges' do
  command <<-"SQL"
      #{init_remote_connection} -e "\
        use employees;\
        SELECT * FROM employees WHERE gender = 'M' AND birth_date = '1965-02-01' AND hire_date > '1990-01-01' ORDER BY last_name, first_name DESC;" \
        > "#{nginx_web_hosting_path}/#{query_output_file}"
SQL
  user 'root'
  action :run
end

template 'index.html' do
  path   "#{nginx_web_hosting_path}/index.html"
  source 'index.html.erb'
  mode '0644'
  variables({
    servername: node['hostname'],
    query_file: query_output_file
  })
end