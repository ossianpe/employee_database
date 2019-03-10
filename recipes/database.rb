#
# Cookbook:: employee_database
# Recipe:: database
#
# Copyright:: 2019, The Authors, All Rights Reserved.

local_mysql_user = node['employee_database']['database']['mysql']['local_username']
local_mysql_password = node['employee_database']['database']['mysql']['local_password']
test_db_path = node['employee_database']['database']['mysql']['database_path']
database_name = node['employee_database']['database']['mysql']['database_name']
remote_mysql_user = node['employee_database']['database']['mysql']['remote_username']
remote_mysql_pass = node['employee_database']['database']['mysql']['remote_password']

# Build cmd for connecting to mysql shell
init_connection=init_mysql_connection(database_name, local_mysql_user, local_mysql_password)

mysql_service database_name do
    port '3306'
    version '5.7'
    initial_root_password local_mysql_password
    mysqld_options({ 'secure-file-priv' => '/usr/local/share' })
    action [:create, :start]
end

directory test_db_path do
    owner 'root'
    group 'root'
    mode '0644'
    recursive true
    action :create
end

git test_db_path do
    repository 'https://github.com/datacharmer/test_db.git'
    revision 'master'
    action :sync
end

directory '/home/mysql' do
    owner 'mysql'
    group 'mysql'
    recursive true
    action :create
end

execute 'load test_db in mysql' do
    command <<-"EOF"
        cd #{test_db_path} && \
            #{init_connection} \
            < #{test_db_path}/employees.sql
    EOF
    user 'root'
    action :run
end

# Create remote user for accessing remotely
execute 'set remote mysql privileges' do
    command <<-"SQL"
        #{init_connection} -e "\
            CREATE USER '#{remote_mysql_user}'@'localhost' IDENTIFIED BY '#{remote_mysql_pass}';\
            GRANT ALL PRIVILEGES ON *.* TO '#{remote_mysql_user}'@'localhost' WITH GRANT OPTION;\
            CREATE USER '#{remote_mysql_user}'@'%' IDENTIFIED BY '#{remote_mysql_pass}';\
            GRANT ALL PRIVILEGES ON *.* TO '#{remote_mysql_user}'@'%' WITH GRANT OPTION;"
    SQL
    user 'root'
    action :run
end


# mysql_config "security settings for #{database_name}" do
#     config_name 'security'
#     instance database_name
#     source 'security.cnf.erb'
#     variables(:secure-file-priv => '')
#     action :create
#     notifies :restart, "mysql_service[#{database_name}]"
# end