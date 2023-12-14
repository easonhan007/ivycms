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

system_navigations = {
	home: '/',
	products: '/products',
	categories: '/categories',
	about_us: '/about',
	news: '/news',
	downloads: '/downloads',
	contact_us: '/contact',
	blog: '/blog',
}

sort = 1
system_navigations.each do |k, v|
	navi_name = k.to_s.titleize()
	puts "Creating navigation item #{navi_name}"
	n = Navigation.find_or_create_by(name: navi_name)
	n.link = v
	n.sorting = sort
	n.save
	sort += 1
end

post_categories = ['About Us', 'News', 'Contact Us', 'Blog']
post_categories.each do |category|
	puts "Creating post category: #{category}"
	PostCategory.find_or_create_by(name: category)	
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

	banners = [
		{name: 'one', url: 'https://plus.unsplash.com/premium_photo-1687710306899-10a3bfcacf9b?q=80&w=1080&h=400&auto=format&fit=crop'},
		{name: 'two', url: 'https://images.unsplash.com/photo-1519822472072-ec86d5ab6f5c?q=80&w=1080&h=400&auto=format&fit=crop'},
		{name: 'three', url: 'https://images.unsplash.com/photo-1481480512736-8798372eaf4a?q=80&w=1080&h=400&auto=format&fit=crop'},
		{name: 'four', url: 'https://images.unsplash.com/photo-1492724724894-7464c27d0ceb?q=80&w=1080&h=400&auto=format&fit=crop'},
	]
	banners.each do |banner|
		puts "Creating banner #{banner[:name]}"
		b = Banner.find_or_create_by(image: banner[:name])
		b.url = banner[:url]
		b.save
	end
	
end #if