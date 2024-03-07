Rails.application.routes.draw do
  root 'foods#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  devise_for :admins, controllers: {
    sessions: 'admins/sessions'
  }
  namespace :admins do
    root 'foods#new'
    resources :foods, only: %i[ index new create edit update destroy ] do
      member do
        get :move_higher
        get :move_lower
      end
    end
  end
  resources :foods, only: %i[ index show ]
  resources :purchase_details, only: %i[ index create update destroy] do
    member do
      patch :add_number
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
