Rails.application.routes.draw do
  root to: 'static_content#home'

  # Authentication
  mount_devise_token_auth_for 'User', at: 'auth', skip: [:omniauth_callbacks]

  # API resources
  scope :api, defaults: { format: :json } do
    scope :v1 do
      get 'about'   => 'static_content#about'
      get 'contact' => 'static_content#contact'
      resources :cards
      resources :templates, only: [:index]
    end
  end
end
