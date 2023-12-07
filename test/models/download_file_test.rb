# == Schema Information
#
# Table name: download_files
#
#  id         :integer          not null, primary key
#  name       :string
#  desc       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  sorting    :integer          default(1)
#
require "test_helper"

class DownloadFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
