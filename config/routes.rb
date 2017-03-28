Rails.application.routes.draw do
  root "pages#home"
  get 'pages/home', to: 'pages#home'
  
  get '/register', to: 'managers#new'
  resources :managers, except: [:new]
end
