json.extract! connection, :id, :title, :recipe_id, :created_at, :updated_at
json.url connection_url(connection, format: :json)
