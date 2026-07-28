class ProfileFactory
  class UnknownRoleError < StandardError; end

  def self.build_for(role, row)
    case role.downcase.to_sym
    when :merchant
      Merchant.create!(
        name: row[:name],
        description: row[:description],
        email: row[:email],
        status: row[:status],
        total_transaction_sum: row[:total_transaction_sum]
      )
    when :admin
      Admin.create!(
        name: row[:name],
        description: row[:description],
        email: row[:email],
        status: row[:status],
      )
    else
      raise UnknownRoleError, "Unknown role: #{role}"
    end
  end
end
