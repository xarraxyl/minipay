class ApiController < ActionController::API
  before_action :authenticate_api_token!

  private

  def authenticate_api_token!
    # &.split(" ")&.last handles the optional Bearer prefix
    token = request.headers["Authorization"]&.split(" ")&.last

    Current.api_user = User.find_signed(token)

    if Current.api_user.nil?
      head :unauthorized
    end
  end
end
