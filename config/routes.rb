Rails.application.routes.draw do

  devise_for :users
  # The priority is based upon order of creation:
  #   first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'game_day', to: 'game_day#index', as: 'game_day'
  get 'drafts/:draft_id/picks', to: 'drafts#picks', as: 'draft_picks'
  get 'rules', to: 'rules#index', as: 'rules'
  get 'admin', to: 'admin#index', as: 'admin'

  # route for the chart data
  get 'second_chance_votes/get_data', to: 'second_chance_votes#get_data',
      as: 'second_chance_votes_get_data'

  get 'second_chance_votes/results', to: 'second_chance_votes#results',
      as: 'second_chance_votes_results'

  resources :seasons, :episodes, :castaways, :drafts, :tribes, :users,
            :vote_outs, :second_chance_votes, :rule_articles, :admin_episodes
  resources :late_picks, only: %w(new create)

end
