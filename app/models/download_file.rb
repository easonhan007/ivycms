# == Schema Information
#
# Table name: download_files
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sorting    :integer          default(1)
#
class DownloadFile < ApplicationRecord
  has_one_attached :content

  validates :name, :content, presence: true
end
