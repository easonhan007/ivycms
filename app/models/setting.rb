# == Schema Information
#
# Table name: settings
#
#  id                  :integer          not null, primary key
#  name                :string
#  url                 :string
#  logo                :string
#  ico                 :string
#  copyright           :text
#  email               :string
#  skype               :string
#  whatsapp            :string
#  phone               :string
#  product_per_page    :integer
#  post_per_page       :integer
#  recommend_per_page  :integer
#  share_code          :text
#  email_user_name     :string
#  email_password      :string
#  email_port          :string
#  email_smtp          :string
#  email_receiver      :string
#  email_sender        :string
#  email_active        :boolean          default(FALSE)
#  ga_code             :text
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  new_arrive_per_page :integer
#
class Setting < ApplicationRecord
	validates :name, presence: true
end
