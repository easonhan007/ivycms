module ProductsHelper
	def image_td(product)
		images = JSON.parse(product.images || "[]") 
		if images.size >= 1
			tag.td {
				tag.div(class: 'w-24 h-24') {
					tag.img(src: images.first, class: "object-cover w-24 h-24 rounded")
				}
			}
		else
			tag.td
		end #if
	end

	def bool_text(value)
		value ? '✅' : '❌' 
	end

end
