json.extract! product, :id, :meta_title, :name, :key, :desc, :specs, :model_string, :content, :price, :url, :new_arrive, :sorting, :hot, :active, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
