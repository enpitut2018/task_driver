Rails.application.routes.draw do
  resources :tasks
  get 'pages/page'

  #get 'endpoints', to: 'endpoints#register'
  
  #ルート
  root 'tasks#index'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
