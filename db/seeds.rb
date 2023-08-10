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

	categories = ['Part 1', 'Part 2', 'Part 3']
	categories.each do |ct|
		puts "Creating category #{ct}"
		Category.find_or_create_by!(name: ct, user_id: 1)	
	end #each

	questons_path = Rails.root.join('db').join('questions.json')
	File.open(questons_path, 'r') do |f|
		json_content = f.read
		questions_list = JSON.parse(json_content)
		questions_list.each do |q|
			category = Category.where(name: q['part'].strip).first
			if category
				q['questions'].each do |question|
					puts "creating #{question} for #{category.name}"
					Question.find_or_create_by!(content: question, date_of_occurrence: q['date'], category_id: category.id, user_id: 1)
				end #each
			end #if
		end #each
	end #open

end