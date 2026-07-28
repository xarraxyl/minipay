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

    user.profile = ProfileFactory.build_for(row[:role], row)
    user.save!
  rescue ProfileFactory::UnknownRoleError, ActiveRecord::RecordInvalid => e
    # add failed rows to the failed array for digest display
    @failed << row.merge(error: e.message)
  end
end
