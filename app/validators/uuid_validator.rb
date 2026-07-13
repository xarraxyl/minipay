class UuidValidator < ActiveModel::EachValidator
  UUID = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i

  def validate_each(record, attribute, value)
    unless value =~ UUID
      msg = options[:message] || "is not a valid UUID"
      msg = options[:type] || :not_uuid
      record.errors.add(attribute, msg)
    end
  end
end
