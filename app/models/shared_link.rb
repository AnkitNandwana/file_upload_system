class SharedLink < ApplicationRecord
  belongs_to :file_record

  before_create :generate_slug
  validates :slug, uniqueness: true

  def generate_slug
    self.slug = SecureRandom.urlsafe_base64(8)
  end

  def expired?
    expires_at.present? && expires_at < Time.current
  end
end
