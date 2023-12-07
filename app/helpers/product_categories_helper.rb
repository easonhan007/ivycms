module ProductCategoriesHelper
	def render_product_category(category)
		if not category.nodes
			tag.li {
				simple_item(category)
			}
		else
			ul = tag.ul {
				child_lis = []
				category.nodes.each { |child| child_lis << render_product_category(child) }
				safe_join  child_lis
			}	
			tag.li {
				safe_join [simple_item(category), ul]
			}
		end #if
	end

	def category_item(category)
		node_name_link = link_to(category.name, '')
		edit_link = link_to(t('Edit'), edit_product_category_path(category), class: 'link link-info')
		add_child_link = link_to(t('Add Child'), new_a_child_product_category_path(category), class: 'link link-primary')
		delete_link = render partial: 'admin/confirm_modal', 
      locals: {
        action_text: t('Delete'), 
        action_obj: category, 
        action_link: link_to(t('Yes'), product_category_path(category), class: "btn btn-error", data: {turbo_method: 'delete'})}
		tag.div(class: 'flex justify-around') {
			safe_join [node_name_link, edit_link, add_child_link, delete_link]
		}
	end

	def simple_item(category)
		link_to(category.name, '')
	end

	def render_path(path_list)
		links = path_list.map {|category| link_to(category.name, product_category_path(category), class: 'link')}
		tag.div(class: 'my-2') {
			safe_join links, tag.span(" > ")
		}
	end

	def render_to_table(category)
		if not category.nodes
			tag.tr {
				td_items(category)
			}
		else
			child_trs = []
			category.nodes.each { |child| child_trs << render_to_table(child) }
			safe_join  child_trs
			safe_join [tag.tr{td_items(category)}, child_trs]
		end #if
	end

	def td_items(category)
		id = tag.td { category.id.to_s }
		level = tag.td {category.level.to_s}
		sorting = tag.td {category.sorting.to_s}
		name = 
		turbo_frame_tag "view" do
			tag.td {
				kls = category.active? ? "": "text-slate-400 dark:text-slate-600"
				link_to name_with_indent(category), 
					show_modal_product_category_path(category), 
					class: "link #{kls}", 
					data: {turbo_frame: "display_modal"}
			}
		end

		edit_link = tag.td {link_to(t('Edit'), edit_product_category_path(category), class: 'link link-info')}

		add_child_link = tag.td {link_to(t('Add Child'), new_a_child_product_category_path(category), class: 'link link-primary')}

		toggle_status_link = tag.td {
			display_text = category.active? ? t("Inactive"): t("Active")
			button_to(display_text, toggle_status_product_category_path(category), class: "link link-secondary", data: {turbo_method: "post"})
		}

		delete_link = tag.td {render partial: 'admin/confirm_modal', 
      locals: {
        action_text: t('Delete'), 
        action_obj: category, 
        action_link: link_to(t('Yes'), product_category_path(category), class: "btn btn-error", data: {turbo_method: 'delete'})} }
		safe_join [level, sorting, name, edit_link, add_child_link, toggle_status_link, delete_link]
	end

	def name_with_indent(category)
		dash = category.level.eql?(1) ? tag.span : tag.span {"- "}
		prefix = tag.span(class: "px-2") * (category.level - 1) 
		safe_join [prefix, dash, tag.span {category.name}]
	end

end
