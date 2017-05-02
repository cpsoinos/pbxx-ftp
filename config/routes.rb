Rails.application.routes.draw do

  devise_for :users
  root to: "ftp_servers#index"

  resources :ftp_servers do
    post :submit_csv
  end
  resources :brands
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
