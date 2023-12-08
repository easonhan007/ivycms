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

  validates :content, presence: true
end
