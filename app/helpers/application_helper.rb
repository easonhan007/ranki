module ApplicationHelper
	def to_md(text)
		options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
		if not text.blank?
			Markdown.new(text, *options).to_html.html_safe
		else
			''
		end #if
	end
end
