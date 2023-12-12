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
require "test_helper"

class InquiryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
