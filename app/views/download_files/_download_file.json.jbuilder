json.extract! download_file, :id, :name, :desc, :content, :created_at, :updated_at
json.url download_file_url(download_file, format: :json)
json.content url_for(download_file.content)
