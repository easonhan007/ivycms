# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

default_email = "ivy_admin@ethanhan.cc"
default_passwd = "ethanhan.cc"
if not User.exists?(email: default_email)
	puts "Creating admin, #{default_email}"
	User.create(email: default_email, password: default_passwd, password_confirmation: default_passwd)	
end #if

if Setting.count < 1
	puts "Creating default setting"
	Setting.create(
		name: 'Ivy CMS',
		copyright: 'CopyRight © 2023 ivy cms',
		email: 'ivycms@ethanhan.cc',
		skype: 'ivycms',
		whatsapp: '13888888888',
		phone: '+86（1234）88888888',
		product_per_page: 20,
		post_per_page: 20,
		recommend_per_page: 8,
		new_arrive_per_page: 8,
	)
end