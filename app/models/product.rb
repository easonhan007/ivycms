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
	has_rich_text :specs

	validates :name, :specs, :content, presence: true

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

end