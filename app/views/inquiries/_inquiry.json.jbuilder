json.extract! inquiry, :id, :name, :email, :phone, :content, :ip, :product_id, :created_at, :updated_at
json.url inquiry_url(inquiry, format: :json)
