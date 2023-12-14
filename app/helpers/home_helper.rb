module HomeHelper

	def build_category(category)
		if not category.nodes
			tag.li {
				category_link(category)
			}
		else
			ul = tag.ul {
				child_lis = []
				category.nodes.each { |child| child_lis << build_category(child) }
				safe_join  child_lis
			}	
			tag.li {
				safe_join [category_link(category), ul]
			}
		end #if
	end

	def category_link(category)
		link_to(category.name, home_category_path(category.fragment))
	end


end
