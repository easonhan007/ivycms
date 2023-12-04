# == Schema Information
#
# Table name: posts
#
#  id            :integer          not null, primary key
#  title         :string
#  desc          :string
#  content       :text
#  image         :string
#  display_title :string
#  category_id   :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require "test_helper"

class PostTest < ActiveSupport::TestCase
  test "belongs to post category" do
    first_post = posts(:one)
    blog_category = post_categories(:blog)
    assert_equal first_post.category_id, blog_category.id
    assert_equal first_post.post_category, blog_category
  end

  test "title is mandatory" do
    post = Post.new(post_category: post_categories(:blog))
    assert !post.valid?
    post.title = "A typical post"
    assert post.valid?
  end

end
