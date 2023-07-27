# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

if Rails.env.eql?('development')
	first_user_email = 'ethanhan@itest.info'
	default_passwd = '123456'
	puts "Create first user #{first_user_email}"
	if not User.exists?(email: first_user_email)
		User.create!(email: first_user_email, password: default_passwd, password_confirmation: default_passwd)
	end

	puts "Create a default deck"
	Deck.find_or_create_by!(name: '2023', user_id: 1)
end