Rails.application.routes.draw do
  root 'foods#index'
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }
  namespace :admins do
    root 'foods#index'
    resources :users, only: %i[index destroy]
    resources :foods, only: %i[new create edit update destroy] do
      member do
        post :move_higher
        post :move_lower
      end
    end
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
  }
  resources :foods, only: %i[index show]
  resources :cart_items, param: :index, only: %i[index create update destroy]
  resources :purchases, only: %i[index new create show]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check
end
