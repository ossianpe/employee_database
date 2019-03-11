# # encoding: utf-8

# Inspec test for recipe employee_database::lb

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe package('nginx') do
  it { should be_installed }
end

describe file('/usr/share/nginx/html/query_output.txt') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
end

describe file('/usr/share/nginx/html/index.html') do
  it { should exist }
  its('type') { should cmp 'file' }
  it { should be_file }
  it { should_not be_directory }
  its('size') { should be > 256 }
  its('mode') { should cmp '00644' }
end