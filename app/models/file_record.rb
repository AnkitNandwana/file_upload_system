class FileRecord < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_one :shared_link, dependent: :destroy

  validates :title, presence: true
  validates :file, presence: true
  validate :file_size_validation

  after_create_commit :process_file

  private

  def file_size_validation
    return unless file.attached?
    if file.blob.byte_size > 1.gigabyte
      errors.add(:file, "must be less than 1GB")
    end
  end

  def process_file
    FileProcessingJob.perform_later(self.id)
  end
end
