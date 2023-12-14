module BannersHelper
	def banner_img_td(banner)
		tag.td {
			link_to(image_tag(banner.url, class: 'w-36 h-20 object-cover'), banner.url)
		}
	end
end
