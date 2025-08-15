class FileRecord < ApplicationRecord
  belongs_to :user
  has_one_attached :file
  has_one :shared_link, dependent: :destroy

  validates :title, presence: true
  validates :file, attached: true, size: { less_than: 1.gigabyte }

  after_create_commit :process_file

  private

  def process_file
    FileProcessingJob.perform_later(self.id)
  end
end
