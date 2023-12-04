json.extract! friend_link, :id, :name, :url, :sorting, :image, :created_at, :updated_at
json.url friend_link_url(friend_link, format: :json)
