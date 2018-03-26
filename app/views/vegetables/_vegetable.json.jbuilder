json.extract! vegetable, :id, :title, :amount, :price, :created_at, :updated_at
json.url vegetable_url(vegetable, format: :json)
