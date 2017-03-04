Rails.application.routes.draw do
  root to: 'static_pages#home'

  # Authentication
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  # API resources
  scope :api, defaults: { format: :json } do
    scope :v1 do
      get 'home'  => 'static_pages#home'
      get 'about' => 'static_pages#about'
      resources :cards
      resources :templates, only: [:index]
    end
  end
end
