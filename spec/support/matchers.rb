require 'rspec/expectations'

UUID_REGEX = /\A\h{8}-\h{4}-(\h)\h{3}-[89ab]\h{3}-\h{12}\z/i

RSpec::Matchers.define :be_uuid do

  match do |uuid_string|
    UUID_REGEX.match(uuid_string)
  end

  description { "be a valid uuid" }
end
