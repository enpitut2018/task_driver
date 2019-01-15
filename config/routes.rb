Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/v1"
  end

  # post 'groups/fork'
  # resources :groups

  # get 'tasks/done'
  # post 'tasks/status_change'
  get 'tasks/importance'
  # resources :tasks

  # get 'pages/page'

  post 'endpoints/register'
  get 'endpoints/getVapidPublicKey'

  #ルート
  # root 'tasks#index'

  # devise_scope :user do
  #   get "sign_in", :to => "users/sessions#new"
  #   post "sign_in", :to => "users/sessions#create"
  #   get "sign_out", :to => "users/sessions#destroy" 
  # end

  scope :v1, defaults: { format: :json } do
    post '/', to: 'graphql#execute'

    devise_for :users, :path => '', controllers: {
      :omniauth_callbacks => 'users/omniauth_callbacks',
      :registrations => 'users/registrations',
      :sessions => 'users/sessions'
    }

    devise_scope :user do
      get 'user', to: 'users/sessions#show'
      post 'sign_up', to: 'users/registrations#create'
      post 'redirect', to: 'users/omniauth_callbacks#redirect'
      post 'callbacklogin', to: 'users/omniauth_callbacks#callbacklogin'
    end
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
