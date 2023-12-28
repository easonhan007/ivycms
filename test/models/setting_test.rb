# == Schema Information
#
# Table name: settings
#
#  id                   :integer          not null, primary key
#  name                 :string
#  url                  :string
#  logo                 :string
#  ico                  :string
#  copyright            :text
#  email                :string
#  skype                :string
#  whatsapp             :string
#  phone                :string
#  product_per_page     :integer
#  post_per_page        :integer
#  recommend_per_page   :integer
#  share_code           :text
#  email_user_name      :string
#  email_passwd         :string
#  email_port           :string
#  email_smtp           :string
#  email_receiver       :string
#  email_sender         :string
#  email_active         :boolean          default(FALSE)
#  ga_code              :text
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  new_arrive_per_page  :integer
#  email_auto_ssl       :boolean          default(TRUE)
#  email_authentication :boolean          default(TRUE)
#  seo_meta_title       :string
#  seo_keywords         :string
#  seo_description      :string
#  theme                :string
#  raw_block            :text
#  cf_site_key          :string
#  cf_secret_key        :string
#
require "test_helper"

class SettingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
