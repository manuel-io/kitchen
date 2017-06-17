json.extract! ingredient, :id, :amount, :unit, :name, :component_id, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
