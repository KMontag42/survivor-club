json.array!(@admin_castaways) do |admin_castaway|
  json.extract! admin_castaway, :id
  json.url admin_castaway_url(admin_castaway, format: :json)
end
