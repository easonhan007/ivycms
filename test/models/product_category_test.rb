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
require "test_helper"

class ProductCategoryTest < ActiveSupport::TestCase

  test "should build tree correctly" do
    parts = product_categories(:parts)
    tree = parts.build_children()
    assert_equal tree[:element].id, parts.id
  end

  test "get parent id from path" do
    res = product_categories(:parts).get_parent_id_from("1", 1)
    assert_equal res, 0

    res = product_categories(:parts).get_parent_id_from("1,2", 2)
    assert_equal res, 1

    res = product_categories(:parts).get_parent_id_from("1,2,3", 2)
    assert_equal res, 1

    res = product_categories(:parts).get_parent_id_from("1,2,3", 3)
    assert_equal res, 2

    res = product_categories(:parts).get_parent_id_from("", 3)
    assert_equal res, 0

    res = product_categories(:parts).get_parent_id_from("1,2,3", 4)
    assert_equal res, 0
  end

end
