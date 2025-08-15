require "zip"
require "securerandom"

class FileProcessingJob < ApplicationJob
  queue_as :default

  def perform(file_record_id)
    file_record = FileRecord.find(file_record_id)
    return unless file_record.file.attached?

    blob = file_record.file.blob
    content_type = blob.content_type || MimeMagic.by_magic(blob.download).type

    if !compressed?(content_type) && blob.byte_size > 1.megabyte
      compress_file(file_record)
    end
  rescue => e
    Rails.logger.error "FileProcessingJob failed: #{e.message}"
    raise
  end

  private

  def compressed?(content_type)
    %w[application/zip application/gzip application/x-gzip].include?(content_type)
  end

  def compress_file(file_record)
    original_blob = file_record.file.blob

    # Use a random UUID for the temp file instead of content-based names
    temp_dir = Rails.root.join("tmp", "compression")
    FileUtils.mkdir_p(temp_dir)
    temp_zip_path = temp_dir.join("#{SecureRandom.uuid}.zip")

    begin
      # Create zip file directly without intermediate temp file
      ::Zip::File.open(temp_zip_path.to_s, ::Zip::File::CREATE) do |zipfile|
        # Use a fixed simple name for the content file
        zipfile.get_output_stream("document.pdf") do |f|
          f.write(original_blob.download)
        end
      end

      # Attach the compressed file
      file_record.file.attach(
        io: File.open(temp_zip_path),
        filename: "#{original_blob.filename.base[0..50]}.zip",
        content_type: "application/zip"
      )
    ensure
      FileUtils.rm_f(temp_zip_path) if File.exist?(temp_zip_path)
    end
  end
end
