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
	belongs_to :category, class_name: 'PostCategory', foreign_key: :category_id
	has_rich_text :content
	before_save :dasherize_display_title

	scope :latest, ->(count) {order('created_at DESC').limit(count)}
	validates :title, presence: true

	def fragment
		self[:display_title].present? ? self[:display_title] : self[:id]
	end

	private
		def dasherize_display_title
			if self[:display_title].present?
				self[:display_title] = self[:display_title].gsub(/[^a-zA-Z0-9_\-\s]/, '').split().map { |word| word.downcase }.join('-')
			end #if
		end

end
