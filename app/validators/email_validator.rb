# picked up straight from the rails docs: https://guides.rubyonrails.org/active_record_validations.html#custom-validators
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless URI::MailTo::EMAIL_REGEXP.match?(value)
      record.errors.add attribute, :not_email, message: "is not a valid email"
    end
  end
end
