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
#  is_md         :boolean          default(FALSE)
#  md_content    :text
#
class Post < ApplicationRecord
	belongs_to :category, class_name: 'PostCategory', foreign_key: :category_id
	has_rich_text :content
	before_save :dasherize_display_title

	scope :published, ->{where(is_draft: false)}
	scope :latest, ->(count) {published.order('created_at DESC').limit(count)}

	validates :title, presence: true
	validates :display_title, uniqueness: true

	def fragment
		self[:display_title].present? ? self[:display_title] : self[:id]
	end

	def title_with_status
		if self[:is_draft]
			"[Draft] 📖 #{self[:title]}"
		else
			self[:title]
		end #if
	end

	private
		def dasherize_display_title
			if self[:display_title].present?
				self[:display_title] = self[:display_title].gsub(/[^a-zA-Z0-9_\-\s]/, '').split().map { |word| word.downcase }.join('-')
			end #if
		end

end
