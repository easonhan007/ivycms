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
#
class Setting < ApplicationRecord
	validates :name, :url, presence: true
	validates :email_sender, email: {mode: :strict, require_fqdn: true}
	validates :email_receiver, email: {mode: :strict, require_fqdn: true}

	def can_inquiry?
		self[:email_user_name].present? and self[:email_passwd].present? and
		self[:email_port].present? and self[:email_smtp].present? and 
		self[:email_sender].present? and self[:email_receiver].present? and
		self[:email_active]
	end

end
