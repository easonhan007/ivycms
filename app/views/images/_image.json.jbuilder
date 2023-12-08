json.extract! image, :id, :content, :created_at, :updated_at
json.url image_url(image, format: :json)
json.content url_for(image.content)
