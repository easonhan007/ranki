class ApplicationController < ActionController::Base
	include Pagy::Backend

	before_action :authenticate_user!, :init_llm, :init_menu

	def init_llm()
		if current_user.gemini_key
			@client = Gemini.new(
			  credentials: {
			    service: 'generative-language-api',
			    api_key: current_user.gemini_key
			  },
			  options: { model: 'gemini-pro', server_sent_events: true }
			)
			return 
		end

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

end
