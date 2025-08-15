# app/models/shared_link.rb
class SharedLink < ApplicationRecord
  belongs_to :file_record
  before_create :set_default_expiration
  before_validation :generate_slug, on: :create

  def set_default_expiration
    self.expires_at ||= 7.days.from_now
  end

  def expiration_status
    return "Never expires" unless expires_at
    "Expires in #{distance_of_time_in_words(Time.current, expires_at)}"
  end

  def generate_slug
    self.slug ||= SecureRandom.urlsafe_base64(8)
  end
end
