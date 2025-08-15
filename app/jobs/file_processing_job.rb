class FileProcessingJob < ApplicationJob
  queue_as :default

  def perform(file_record_id)
    file_record = FileRecord.find(file_record_id)
    return unless file_record.file.attached?

    # Detect file type
    blob = file_record.file.blob
    content_type = blob.content_type || MimeMagic.by_magic(blob.download).type

    # Compress if not already compressed
    if !compressed?(content_type) && blob.byte_size > 1.megabyte
      compress_file(file_record)
    end
  end

  private

  def compressed?(content_type)
    %w[application/zip application/gzip application/x-gzip].include?(content_type)
  end

  def compress_file(file_record)
    # Implementation for file compression
    # This is a simplified version - you might want to use rubyzip for more robust compression
    original_blob = file_record.file.blob
    compressed_file = Tempfile.new([ "compressed", ".zip" ])

    begin
      Zip::File.open(compressed_file.path, Zip::File::CREATE) do |zipfile|
        zipfile.add(original_blob.filename.to_s, original_blob.download)
      end

      file_record.file.attach(
        io: File.open(compressed_file.path),
        filename: "#{original_blob.filename.base}.zip",
        content_type: "application/zip"
      )
    ensure
      compressed_file.close
      compressed_file.unlink
    end
  end
end
