require 'rails_helper'

RSpec.describe User, type: :model do
  it "must be a merchant by default" do
    user = create(:user)

    expect(user.role).to eq("merchant")
  end
end
