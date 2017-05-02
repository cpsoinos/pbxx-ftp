json.extract! ftp_server, :id, :brand_id, :url, :port, :username, :password, :created_at, :updated_at
json.url ftp_server_url(ftp_server, format: :json)
