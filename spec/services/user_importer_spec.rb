require 'rails_helper'

RSpec.describe UserImporter, type: :service do
  context "admin" do
    it "can be imported when valid" do
      admin_row = [ { email_address: 'test@email.com', password: 'passpass', role: 'admin' } ]
      digest = nil

      expect {
        digest = UserImporter.call(admin_row)
      }.to change { User.count }.from(0).to(1)
      expect(digest[:processed]).to eq(1)
      expect(digest[:skipped].size).to eq(0)
      expect(digest[:failed].size).to eq(0)

      imported_user = User.last

      expect(imported_user).to have_attributes(
        email_address: "test@email.com",
        profile_type: "Admin"
      )
      # check password separately
      expect(imported_user.authenticate('passpass')).to be_truthy
    end

    it "cannot be import without a password" do
      admin_row = [ { email_address: 'test@email.com', role: 'admin' } ]
      digest = nil

      expect {
        digest = UserImporter.call(admin_row)
      }.not_to change { User.count }
      expect(digest[:processed]).to eq(1)
      expect(digest[:skipped].size).to eq(0)
      expect(digest[:failed].size).to eq(1)
    end
  end

  context "merchant" do
    it "can be imported when valid" do
      merchant_row = [ {
        email_address: 'test@email.com',
        password: 'passpass',
        role: 'merchant',
        name: "test merchant",
        description: "test description",
        email: "merchant@email.com",
        status: "active",
        total_transaction_sum: 5
      } ]

      digest = nil # we need this to yank the context out of the expect block

      expect {
        digest = UserImporter.call(merchant_row)
      }.to change { User.count }.from(0).to(1)
      expect(digest[:processed]).to eq(1)
      expect(digest[:skipped].size).to eq(0)
      expect(digest[:failed].size).to eq(0)

      imported_user = User.last
      imported_merchant = Merchant.last

      expect(imported_user).to have_attributes(
        email_address: "test@email.com",
        profile_type: "Merchant"
      )
      # Verify password separately
      expect(imported_user.authenticate('passpass')).to be_truthy
      expect(imported_merchant).to have_attributes(
        email: "merchant@email.com",
        name: "test merchant",
        description: "test description",
        status: "active",
        total_transaction_sum: 5
      )
    end
  end
end
