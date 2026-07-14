class UuidValidator < ActiveModel::EachValidator
  UUID = /\A[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}\z/i

  def validate_each(record, attribute, value)
    unless value =~ UUID
      record.errors.add(attribute, :not_uuid, message: "is not a valid UUID")
    end
  end
end
