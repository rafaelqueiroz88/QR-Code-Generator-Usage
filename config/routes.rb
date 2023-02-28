Rails.application.routes.draw do
  root "cars#index"
  resources :cars

  controller :cars do
    get :qr_code_generator
    get :qr_code_download
  end
end
