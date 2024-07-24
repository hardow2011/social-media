Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', confirmation: 'verification', unlock: 'unblock', registration: 'register', sign_up: 'signup' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root "pages#home"

  resources :communities, path: 'c' do
    resources :posts
  end
  post 'vote_post/:id', to: 'posts#vote_post', as: 'vote_post'
  post 'join_community/:id', to: 'communities#join_community', as: 'join_community'
  resources :comments
  get '/u/:id', to: 'users#show', as: 'user'
end
