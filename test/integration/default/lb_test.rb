# # encoding: utf-8

# Inspec test for recipe employee_database::lb

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('nginx') do
  it { should be_installed }
end

describe file('/etc/nginx/conf.d/default.conf') do
  it { should_not exist }
end

describe file('/etc/nginx/sites-enabled/000-default') do
  it { should_not exist }
end

describe file('/etc/nginx/conf.d/load-balancer.conf') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
  its('size') { should be > 512 }
  its('mode') { should cmp '00644' }
end

describe port(80) do
  it { should be_listening }
end

describe port(443) do
  it { should_not be_listening }
end