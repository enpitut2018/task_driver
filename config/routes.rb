Rails.application.routes.draw do
  resources :groups
  resources :tasks
  get 'pages/page'
  post 'tasks/status_change'
  
  #ルート
  root 'tasks#index'
  devise_for :users, controllers: { 
  	omniauth_callbacks: 'users/omniauth_callbacks',
  	registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
