# frozen_string_literal: true

describe file('/opt/saltstack/salt/salt-call') do
  it { should exist }
end

expected_salt_version = Regexp.escape(input('SALT_VERSION'))

describe command('salt-call --version') do
  its('exit_status') { should eq 0 }
  its('stdout') { should match(/\s#{expected_salt_version}\s/) }
end
