Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root "home#index"

  resources :doctors do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end
  resources :patients do
    member do
      get 'edit_password'
      patch 'update_password'
    end
  end
  resource :user, only: %i[edit update destroy]
  resources :users, only: %i[index show]

  # get "/pages/:page" => "pages#show", as: :page

  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#internal_server_error', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
