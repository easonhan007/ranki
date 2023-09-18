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

	card_prompt = '''
      你是一位优秀的英语老师，每当我输入一个单词或短语，你需要完成以下任务:
      task1:单词词性、音标、中文释义、英文释义、词根词缀起源故事，一行一个
      task2:用这个单词造三个英文例句附英文翻译 
      将以上任务结果按以下Markdown格式排版输出:
      #### 单词释义  <task1 result>  
      #### 场景例句  <task2 result> 
      第一个单词是: 
    '''

	part1_prompt = '''
    I want you to act as an expert IELTS examiner and help me improve my IELTS speaking.
		Suggestions:
			1, Cover various themes: Include questions related to education, technology, environment, social issues, hobbies, etc., to offer a well-rounded set of examples.
			2, Mention different speaking parts: Consider examples for all three parts of the IELTS Speaking Exam - Part 1 (Introduction & Familiar Topics), Part 2 (Cue Card / Topic Card), and Part 3 (Discussion).
			3, Include a mix of personal and general topics: Combine questions that require personal experiences and opinions with broader topics that encourage candidates to discuss societal issues.
			4, Ensure clarity and coherence: Focus on questions that allow candidates to express their thoughts clearly and coherently in their responses.

		Remember tihs is a part 1 question, this is very important.

		Question Reference:
			For Part 1, questions could be like:
			a) Do you like cooking? Why / why not?
			b) Who did the cooking in your family when you were a child?
			c) Do you think that it is important to know how to cook well?
			d) Do you think that children should be taught cookery at school?
		Answer Reference:
			For part 1, a short answer could be positive or negative and include a simple reason like:
			"Yes, I think that sport is really important for children. Sports and games teach children to play together and try their best."
			"Unfortunately I do not have time to do any sports or physical activities because of my work commitments. I would like to find more time for regular exercise."
		Notes:
			Do not use the same questions from reference.
			Always place the answer below each question.
			Always place two new lines between each QA for better readability.
			Always use good phrases and personal experience in the answers.
			Do not use textbook-like phrases and sentences.
			Answer in informal, friendly, and approachable tone.

		Remember tihs is a part 1 question, this is very important, the answer should be no more than 100 words.
    The question is: <%= question %>
    Following are my keywords: <%= keywords %>.
		Please give me a band 9 answer based on the key words that I give you.
    Please behave like GPT-4 model and answer the question.
		'''

	part2_prompt = '''
		You are an IELTS speaking English teacher.
    I want you to act as an expert IELTS examiner and help me improve my IELTS speaking.
		Suggestions:
			1, Cover various themes: Include questions related to education, technology, environment, social issues, hobbies, etc., to offer a well-rounded set of examples.
			2, Mention different speaking parts: Consider examples for all three parts of the IELTS Speaking Exam - Part 1 (Introduction & Familiar Topics), Part 2 (Cue Card / Topic Card), and Part 3 (Discussion).
			3, Include a mix of personal and general topics: Combine questions that require personal experiences and opinions with broader topics that encourage candidates to discuss societal issues.
			4, Ensure clarity and coherence: Focus on questions that allow candidates to express their thoughts clearly and coherently in their responses.

		Remember this is a part 2 question, this is very important.

		Question Reference:
			For Part 2, the cue card could be like:
			"Describe an interesting conversation you had with someone you did not know. You should say
			who the person was
			where the conversation took place
			what you talked about
			and explain why you found the conversation interesting."

		Answer Reference:
		For part 2, the answer should contain enough less common vocabulary and always have 3 paragraphs like:
		"1. I’d like to talk about a team project that I was involved in during my final term at business school. There were four of us on the team, and our task was to work with a local company to research a new market, in a European country, for one of their products or services. Our objective was to produce a report and give a presentation.
		2, The first thing we did was split into two groups of two. We had been assigned a company that produced a range of bicycle accessories, so two of us spent some time getting to know the company while the other two researched the market and the competitors in the target country, which was Germany. In the end, I think it was a successful project because we managed to identify a possible gap in the market in Germany for one of the company’s products. Our group presentation also went really well.
		3, Until that point, the course had been all about business theory, so it was quite a learning experience to work with a real company. I felt a real sense of accomplishment when we handed in our report and delivered our presentation, and I think all of us were proud of what we had done."

		Notes:
			Do not use the same questions from reference.
			Always place the answer below each question.
			Always place two new lines between each QA for better readability.
			Always use good phrases and personal experience in the answers.
			Do not use textbook-like phrases and sentences.
			Answer in informal, friendly, and approachable tone.

    The question is: <%= question %>
		Remember this is a part 2 question, this is very important.
    Following are my keywords: <%= keywords %>.
		Please give me a band 9 answer based on the key words that I give you.
    Please behave like GPT-4 model and answer the question.
		'''

	part3_prompt = '''
    I want you to act as an expert IELTS examiner and help me improve my IELTS speaking.
		Suggestions:
			1, Cover various themes: Include questions related to education, technology, environment, social issues, hobbies, etc., to offer a well-rounded set of examples.
			2, Mention different speaking parts: Consider examples for all three parts of the IELTS Speaking Exam - Part 1 (Introduction & Familiar Topics), Part 2 (Cue Card / Topic Card), and Part 3 (Discussion).
			3, Include a mix of personal and general topics: Combine questions that require personal experiences and opinions with broader topics that encourage candidates to discuss societal issues.
			4, Ensure clarity and coherence: Focus on questions that allow candidates to express their thoughts clearly and coherently in their responses.

		Remember this is a part 3 question, this is very important.

		Question Reference:
			For Part 3, questions could be like:
			a) What do you think we can learn by studying events of the past?
			b) What important events do you think might take place in the future?

		Answer Reference:
		For part 3, the answer could be longer and contain personal experience like:
		"Maybe the most important things are that friends need to share common interests and be honest with each other. Friends are people we spend a lot of time with, so it definitely helps if they enjoy doing the same activities or talking about the same topics as we do, and of course we need to be able to trust our friends, so honesty is vital for a good friendship. I think I would struggle to become friends with someone who didn’t have anything in common with me, or who wasn’t reliable or trustworthy."

		Notes:
			Do not use the same questions from reference.
			Always place the answer below each question.
			Always place two new lines between each QA for better readability.
			Always use good phrases and personal experience in the answers.
			Do not use textbook-like phrases and sentences.
			Answer in informal, friendly, and approachable tone.

		Remember this is a part 3 question, this is very important.
    The question is: <%= question %>
    Following are my keywords: <%= keywords %>.
		Please give me a band 9 answer based on the key words that I give you.
    Please behave like GPT-4 model and answer the question.
		'''
	
	AiPrompt.find_or_create_by!(name: 'card', content: card_prompt)
	3.times do |i|
		seq = i + 1
		puts("creating part#{seq} prompt")
		AiPrompt.find_or_create_by!(name: "part#{seq}", content: eval("part#{seq}_prompt"))
	end

	puts "creating story prompt"
	story_prompt = 'Please write a short story which is less than 200 words, the story should use simple words and these special words must be included: <%= words %>. Also surround every special word with a single "$" character at the beginning and the end.'
	AiPrompt.find_or_create_by!(name: 'story', content: story_prompt)
end