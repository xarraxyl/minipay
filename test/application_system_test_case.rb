require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  include FactoryBot::Syntax::Methods

  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ]

  def sign_in(user)
    # manually create the session on the backend
    session = user.sessions.create!

    # load selenium context
    visit root_path

    # generate cookie
    cookie_value = Rails.application.message_verifier("signed cookie").generate(session.id)

    # add cookie to the browser
    page.driver.browser.manage.add_cookie(
      name: "session_id",
      value: cookie_value,
      path: "/",
      httponly: true
    )
  end
end
