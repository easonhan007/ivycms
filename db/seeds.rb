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

if Rails.env.development?
	puts "Creating friend links"
	FriendLink.find_or_create_by(name: 'Amazon', url: 'https://www.amazon.com/', sorting: 1)
	FriendLink.find_or_create_by(name: 'Walmart', url: 'https://www.walmart.com/', sorting: 2)
	FriendLink.find_or_create_by(name: 'Amazon UK', url: 'https://www.amazon.co.uk/', sorting: 3)
	FriendLink.find_or_create_by(name: 'Shopify', url: 'https://www.shopify.com', sorting: 4)

	puts "Creating Product Category"
	level2 = {
		Computer: ['CPU', 'Memery', 'Hard Dick'],
		Mobile: ['iPhone Se3', 'Phone 13', 'iPhone 13 pro', 'iPhone 14', 'iPhone 14 Pro Max'],
		Accessories: ['Mouse', 'Keyboard', 'Charger']
	}
	%w(Computer Mobile Speaker Accessories).each_with_index do |cname, index|
		c = ProductCategory.find_or_create_by(name: cname, sorting: index+1, level: 1)
		c.path = "#{c.id}"
		c.save
		if not c.has_children?
			sym_c = c.name.to_sym
			if level2.key?(sym_c)
				level2[sym_c].each_with_index do |l2_c, index|
					c.create_child(name: l2_c, sorting: index+1)
				end #each
			end #if
		end 
	end 
	
end #if