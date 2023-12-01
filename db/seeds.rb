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