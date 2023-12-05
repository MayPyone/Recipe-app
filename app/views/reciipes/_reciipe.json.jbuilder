json.extract! reciipe, :id, :name, :preparation_time, :cooking_time, :description, :public, :user_id, :created_at, :updated_at
json.url reciipe_url(reciipe, format: :json)
