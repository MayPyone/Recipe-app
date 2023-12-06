json.extract! ingredient, :id, :name, :quantity, :measurement_unit, :value, :reciipe_id, :created_at, :updated_at
json.url ingredient_url(ingredient, format: :json)
