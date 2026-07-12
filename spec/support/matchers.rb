require 'rspec/expectations'

UUID_REGEX = /\A\h{8}-\h{4}-(\h)\h{3}-[89ab]\h{3}-\h{12}\z/i

RSpec::Matchers.define :be_uuid do
  match do |uuid_string|
    UUID_REGEX.match(uuid_string)
  end

  description { "be a valid uuid" }
end

RSpec::Matchers.define :have_error do |attribute, error_type|
  match do |record|
    record.errors.where(attribute, error_type).present?
  end

  failure_message do
    "expected error #{error_type} on attribute #{attribute} to be present"
  end
end
