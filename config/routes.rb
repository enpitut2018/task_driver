Rails.application.routes.draw do
  resources :groups
  resources :tasks
  get 'pages/page'
  post 'tasks/status_change'
  
  #ルート
  root 'tasks#index'
  
  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks',
    :registrations => 'users/registrations',
    :sessions => 'users/sessions'  
   }

  devise_scope :user do
    get "sign_in", :to => "users/sessions#new"
    get "sign_out", :to => "users/sessions#destroy" 
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
