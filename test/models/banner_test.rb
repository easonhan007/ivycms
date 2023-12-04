# == Schema Information
#
# Table name: banners
#
#  id         :integer          not null, primary key
#  image      :string
#  url        :string
#  sorting    :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class BannerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
