Rails.application.routes.draw do
  root "cars#index"
  resources :users
  resources :cars

  match '/auth', to: 'users#auth', via: :get
  match '/remote_ping', to: 'users#remote_ping', via: :get
  match '/remote_authentication', to: 'users#remote_authentication', via: :post

  controller :users do
    get :qr_code_generator
    get :qr_code_download
  end
end
