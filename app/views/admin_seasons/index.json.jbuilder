json.array!(@admin_seasons) do |admin_season|
  json.extract! admin_season, :id
  json.url admin_season_url(admin_season, format: :json)
end
