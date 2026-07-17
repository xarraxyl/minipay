namespace :import do
  desc "Import users from a CSV file"
  task users: :environment do
    file_path = ENV["FILE"]

    csv_enumerator = CSV.read(file_path)
    total_processed = 0

    # `each_slice` prevents loading a large file into memory
    csv_enumerator.each_slice(1000) do |slice|
      row_hashes = chunk.map(&:to_h)
      row_size = row_hashes.size
      total_processed += row_size

      digest = UserImporter.call(row_hashes)

      puts <<~DIGEST
      skipped:
      #{digest[:skipped].each { |s| puts s.inspect }}
      failed:
      #{digest[:failed].each { |f| puts f.inspect }}
      DIGEST
    end

    puts "Processed #{total_processed} in total"
  end
end
