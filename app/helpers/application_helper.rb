module ApplicationHelper
	include Pagy::Frontend

	def insert_locale(path)
		"/#{@locale}#{path}"
	end

	def build_breadcrumbs
		return if controller_name.eql?("settings")
		breadcrumbs = []
		root = {text: t(controller_name), path: send("#{controller_name}_path")}
		breadcrumbs << root
		if not action_name.eql?('index')
			model_instance = instance_variable_get("@#{controller_name.singularize()}")
			case action_name
			when "edit" then
				second = {text: model_instance.id, path: url_for(controller: controller_name, acton: 'show', id: model_instance.id)}
				breadcrumbs << second
				breadcrumbs << {text: t("Edit")}
			when "show" then
				breadcrumbs << { text: model_instance.id }
			else
				second = {text: t(action_name.capitalize)}	
				breadcrumbs << second
			end #case
		end

		items = []
		tag.div(class: "text-sm breadcrumbs mx-4 mt-2") {
			tag.ul {
				breadcrumbs.each do |item|
					if item.key?(:path) 
						items << tag.li {link_to item[:text], item[:path]}
					else
						items << tag.li(item[:text])
					end #if
				end #each
				safe_join items

			}
		}

	end

	def to_md(text)
		options = [:hard_wrap, :autolink, :no_intra_emphasis, :fenced_code_blocks]
		if not text.blank?
			Markdown.new(text, *options).to_html.html_safe
		else
			''
		end #if
	end


end
