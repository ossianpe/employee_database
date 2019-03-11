default['employee_database']['database']['mysql']['home_path'] = '/home/mysql'
default['employee_database']['database']['mysql']['database_path'] = '/home/mysql/test_db'
default['employee_database']['database']['mysql']['database_name'] = 'employee_db'
default['employee_database']['database']['mysql']['query_output_file'] = 'query_output.txt'

default['employee_database']['lb']['config_to_remove'] = ['/etc/nginx/conf.d/default.conf', '/etc/nginx/sites-enabled/000-default']