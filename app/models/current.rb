class Current < ActiveSupport::CurrentAttributes
  # browser
  attribute :session
  delegate :user, to: :session, allow_nil: true

  # API
  attribute :api_user
end
