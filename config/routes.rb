Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
  post 'groups/fork'
  resources :groups
  get 'tasks/done'
  resources :tasks
  get 'pages/page'
  post 'tasks/status_change'
  get 'endpoints', to: 'endpoints#register'

  
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
