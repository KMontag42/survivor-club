Rails.application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation:
  #   first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'
  get 'game_day', to: 'game_day#index', as: 'game_day'
  get 'drafts/:draft_id/picks', to: 'drafts#picks', as: 'draft_picks'
  resources :seasons, :episodes, :contestants, :drafts, :tribes, :users,
            :vote_out
  resources :late_picks, only: %w(new create)

end
