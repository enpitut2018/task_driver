Rails.application.routes.draw do
  get 'pages/page'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
