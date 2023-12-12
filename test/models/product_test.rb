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
require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
