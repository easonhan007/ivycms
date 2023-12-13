# == Schema Information
#
# Table name: navigations
#
#  id         :integer          not null, primary key
#  name       :string
#  link       :string
#  dropdown   :boolean          default(FALSE)
#  sorting    :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class NavigationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
