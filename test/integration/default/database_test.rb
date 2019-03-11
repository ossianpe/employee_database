# # encoding: utf-8

# Inspec test for recipe employee_database::database

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe mysql_conf('/etc/mysql-employee_db/my.cnf') do
  its('mysqld.user') { should eq 'mysql' }
  its('mysqld.pid-file') { should eq '/run/mysql-employee_db/mysqld.pid' }
  its('mysqld.socket') { should eq '/run/mysql-employee_db/mysqld.sock' }
  its('mysqld.port') { should cmp 3306 }
end

describe directory('/home/mysql/test_db') do
  it { should exist }
  it { should be_directory }
  it { should_not be_file }
  its('owner') { should eq 'root' }
end