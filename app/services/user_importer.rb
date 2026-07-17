class UserImporter
  attr_accessor :processed, :failed

  def initialize(rows)
    @rows = rows
    @processed = 0
    @skipped = []
    @failed = []
  end

  def self.call(rows)
    new(rows).import
  end

  def import
    @rows.each do |row|
      process_row(row)
    end

    # digest
    {
      processed: @processed,
      skipped: @skipped,
      failed: @failed
    }
  end

  private

  def process_row(row)
    user = User.find_or_initialize_by(email_address: row[:email_address])
    @processed += 1

    unless user.new_record?
      @skipped << row
      return
    end

    user.password = row[:password]

    unless user.valid?
      @failed << row
      return
    end

    user.role = row[:role]

    case user.role
    when "merchant"
      merchant = Merchant.create(
        name: row[:name],
        description: row[:description],
        email: row[:email],
        status: row[:status],
        total_transaction_sum: row[:total_transaction_sum]
      )

      user.merchant = merchant
      user.save!
    when "admin"
      user.save!
    else
      raise "Unknown value in the row column"
    end
  end
end
