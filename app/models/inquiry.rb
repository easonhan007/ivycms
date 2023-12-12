# == Schema Information
#
# Table name: inquiries
#
#  id         :integer          not null, primary key
#  name       :string
#  email      :string
#  phone      :string
#  content    :text
#  ip         :string
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Inquiry < ApplicationRecord
	belongs_to :product, optional: true

	validates :name, :phone, :content, :email, presence: true
	validates :email, email: {mode: :strict, require_fqdn: true}
end
