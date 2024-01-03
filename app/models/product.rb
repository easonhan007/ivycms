# == Schema Information
#
# Table name: products
#
#  id           :integer          not null, primary key
#  meta_title   :string
#  name         :string
#  key          :string
#  desc         :string
#  specs        :text
#  model_string :string
#  content      :text
#  price        :string
#  url          :string
#  new_arrive   :boolean          default(TRUE)
#  sorting      :integer          default(1)
#  hot          :boolean          default(TRUE)
#  active       :boolean          default(TRUE)
#  recommend    :boolean          default(TRUE)
#  category_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  images       :text
#
class Product < ApplicationRecord
	belongs_to :category, class_name: 'ProductCategory', foreign_key: 'category_id'
	has_rich_text :content

	before_save :dasherize_url

	validates :name, :specs, :content, presence: true
	scope :active, -> { where(active: true) }
	scope :by_sorting, -> {order("sorting ASC")}
	scope :hot, ->(count) { active.by_sorting.where(hot: true).limit(count) }
	scope :recommend, ->(count) { active.by_sorting.where(recommend: true).limit(count) }
	scope :new_arrive, ->(count) { active.by_sorting.where(new_arrive: true).limit(count) }
	
	def parsed_images
		if self[:images]
			JSON.parse(self[:images]).map {|img_url| get_signed_id_from(img_url)}
		else
			[]
		end #unless
	end

	# http://localhost:3000/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6OTgsInB1ciI6ImJsb2JfaWQifX0=--6dfbd3d37bd323c1d22d5365e1b37ac998e19e9a/postman-tile.png?locale=en
	def get_signed_id_from(url)
		step_1 = url.split('redirect/').last
		step_1.split('/').first
	end

	def all_images
		JSON.parse(self[:images])
	end

	def first_image
		all_images.try(:first)
	end

	def fragment
		self[:url].present? ? self[:url] : self[:id]
	end

	def display_name
		self[:meta_title].present? ? self[:meta_title] : self[:name]
	end

	private
		def dasherize_url
			if self[:url].present?
				self[:url] = self[:url].gsub(/[^a-zA-Z0-9_\-\s]/, '').split().map { |word| word.downcase }.join('-')
			end #if
		end

end
