# == Schema Information
#
# Table name: categories
#
#  id          :integer          not null, primary key
#  level       :integer          default(1)
#  path        :string
#  name        :string
#  key         :string
#  description :string
#  image       :string
#  url         :string
#  type        :string
#  sorting     :integer          default(1)
#  active      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  content     :text
#
class Category < ApplicationRecord
	validates :name, presence: true
  scope :active, ->{ where(active: true) }

	def fragment
		(self[:url].present? and not self[:url].blank?) ? self[:url] : self[:id]
	end

end
