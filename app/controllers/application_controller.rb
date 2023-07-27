class ApplicationController < ActionController::Base
	before_action :authenticate_user!, :init_openai

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
end
