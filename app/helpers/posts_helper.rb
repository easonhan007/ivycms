module PostsHelper
	def post_image(post)
		img_url = post.image.present? ? post.image : "https://images.unsplash.com/photo-1510776632413-f3e527a8dc42?q=80&w=128&auto=format&fit=crop"
		tag.td {
			tag.img class: "w-32 h-24", alt: post.desc, src: img_url
		}
	end
end
