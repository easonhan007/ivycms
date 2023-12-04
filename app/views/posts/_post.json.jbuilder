json.extract! post, :id, :title, :desc, :content, :image, :display_title, :category_id, :created_at, :updated_at
json.url post_url(post, format: :json)
