json.array!(@users) do |user|
  json.extract! user, :id, :name, :phone, :age
  json.url user_url(user, format: :json)
end
