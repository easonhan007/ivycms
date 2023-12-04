# == Schema Information
#
# Table name: friend_links
#
#  id         :integer          not null, primary key
#  name       :string
#  url        :string
#  sorting    :integer          default(1)
#  image      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class FriendLinkTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
