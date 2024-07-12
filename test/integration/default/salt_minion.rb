# frozen_string_literal: true

describe file('/opt/saltstack/salt/salt-call') do
  it { should exist }
end

describe command('salt-call --version') do
  its('exit_status') { should eq 0 }
end
