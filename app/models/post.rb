# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string
#  desc          :string
#  content       :text
#  image         :string
#  display_title :string
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Post < ApplicationRecord
	belongs_to :post_category, class_name: 'PostCategory', foreign_key: :category_id
	has_rich_text :content

	validates :title, presence: true
end
