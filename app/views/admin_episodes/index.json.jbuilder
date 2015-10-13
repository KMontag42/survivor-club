json.array!(@admin_episodes) do |admin_episode|
  json.extract! admin_episode, :id
  json.url admin_episode_url(admin_episode, format: :json)
end
