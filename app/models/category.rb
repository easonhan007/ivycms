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
#
class Category < ApplicationRecord
	validates :name, presence: true
end