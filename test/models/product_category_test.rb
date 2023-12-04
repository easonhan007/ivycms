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

  test "default attributes" do
    category = ProductCategory.new()
    assert category.active
    assert_equal category.level, 1
    assert_equal category.sorting, 1
  end

  test "name is mandatory" do
    category = ProductCategory.new()
    assert !category.valid?

    category.name = "fruit"
    assert category.valid?

  end

  # parts
  #   - iphone
  #     - iphone 14
  #     - iphone 14 pro
  #     - iphone 14 max
  #   - ipad
  test "should build tree correctly" do
    parts = product_categories(:parts)
    tree = parts.build_children()
    assert_equal tree[:element].id, parts.id
    assert_equal tree[:children].size, 2

    assert_equal tree[:children].first[:element], product_categories(:iphone)
    assert_equal tree[:children].last[:element], product_categories(:ipad)


    assert_equal tree[:children].first[:children].size, 3
    assert tree[:children].last[:children].empty?

    assert_equal tree[:children].first[:children].first[:element].id, product_categories(:iphone14).id
    assert_equal tree[:children].first[:children].second[:element].id, product_categories(:iphone14pro).id
    assert_equal tree[:children].first[:children].last[:element].id, product_categories(:iphone14max).id
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

  test "path of cateory level 1 should set to its id" do
    fruit = ProductCategory.create(name: 'fruit')
    assert_equal fruit.path, "#{fruit.id}"
  end

  test "child should set its id and level correctly" do
    ipad = product_categories(:ipad)
    ipad_pro = ipad.create_child(name: 'ipad pro')
    assert_equal ipad_pro.path, "#{ipad.id},#{ipad_pro.id}"
    assert_equal ipad_pro.level, (ipad.level + 1)
  end 

  test "should build the site's category correctly" do
    categories = ProductCategory.build()
    assert_equal categories.size, 1
    assert_equal categories.first, product_categories(:parts).build_children()

    # add some categories
    fruit = ProductCategory.create(name: 'fruit')
    assert_equal fruit.level, 1
    assert_equal fruit.path, "#{fruit.id}"

    pear = fruit.create_child(name: 'pear')
    orange = fruit.create_child(name: 'orange')
    grape = fruit.create_child(name: 'grape')

    new_categories = ProductCategory.build()
    assert_equal new_categories.size, 2
    assert_equal new_categories.last, fruit.build_children()
  end

  test "should destroy all children" do
    parts = product_categories(:parts)
    parts.destroy_with_children()

    assert_equal ProductCategory.count, 0
  end

  test "should destroy a record when it has no children" do
    ipad = product_categories(:ipad)

    assert_difference 'ProductCategory.count', -1 do
      ipad.destroy_with_children()
    end 

    iphone14 = product_categories(:iphone14)
    assert_difference 'ProductCategory.count', -1 do
      iphone14.destroy_with_children()
    end 

  end

  test "should parse path to category array correctly" do
    iphone14 = product_categories(:iphone14)
    category_list = iphone14.path_to_category_arr()
    assert_equal category_list.first, product_categories(:parts)
    assert_equal category_list.second, product_categories(:iphone)
    assert_equal category_list.last, iphone14
  end

end
