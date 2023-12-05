class DownloadFile < ApplicationRecord
  has_one_attached :content

  validates :name, :content, presence: true
end
