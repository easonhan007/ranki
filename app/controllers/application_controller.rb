class ApplicationController < ActionController::Base
	include Pagy::Backend

	before_action :authenticate_user!, :init_openai, :init_menu, :setup_gemini

	def init_openai()
		key = current_user.openai_key || ENV.fetch('OPENAI_API_KEY') rescue ''
		domain = current_user.openai_proxy || ENV.fetch('OPENAI_PROXY') rescue ''
		if not key.blank?
			if not domain.blank?
				@client = OpenAI::Client.new(
					access_token: key,
					uri_base: domain,
					request_timeout: 240
				)
			else
				@client = OpenAI::Client.new(
					access_token: key,
					request_timeout: 240
				)
			end
		else
			@client = nil
		end
	end

	def init_menu()
		@menu = {
			Home: '/',
			Cards: cards_path,
			Decks: decks_path,
			Stories: stories_path,
			Questions: questions_path,
			Categories: categories_path,
		}
	end

  def can_quick_new_card
    @can_new_card = true
  end

	# there is a problem here
	# if user set the openai key in the first place
	# and then set the gemini key
	# then the client will be overwritten by gemini client 
	# since the gemini service is for free now 
	# I will not fix this issue 
	def setup_gemini
		if current_user.gemini_key.present?
			@client = Gemini.new(
				credentials: {
					service: 'generative-language-api',
					api_key: current_user.gemini_key
				},
				options: { model: 'gemini-pro', server_sent_events: false }
			)
			@client_type = 'gemini'
		end #if
	end

end
