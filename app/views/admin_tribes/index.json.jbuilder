json.array!(@admin_tribes) do |admin_tribe|
  json.extract! admin_tribe, :id
  json.url admin_tribe_url(admin_tribe, format: :json)
end
