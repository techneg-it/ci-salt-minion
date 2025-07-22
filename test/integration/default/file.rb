# frozen_string_literal: true

describe file('/testing.txt') do
  it { should exist }
  its('content') { should match(/line 1/) }
end
