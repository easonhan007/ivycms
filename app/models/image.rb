# == Schema Information
#
# Table name: images
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alt        :string
#
class Image < ApplicationRecord
  has_one_attached :content
  attr_accessor :seq

  # validates :content, presence: true

  validate :correct_content_mime_type

  private

  def correct_content_mime_type
    Rails.logger.warn(content.content_type)
    if content.attached? && !content.content_type.in?(%w(image/png image/jpeg image/gif image/webp))
      errors.add(:content, 'Must be an image file ')
    end
  end

  def self.find_from(signed_ids)
    blobs = signed_ids.map {|signed_id| ActiveStorage::Blob.find_signed(signed_id)}.compact()
    image_ids = blobs.map {|blob| blob.attachments.first}.pluck(:record_id)
    Image.find(image_ids)
  end

end
