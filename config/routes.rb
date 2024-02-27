Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "/king", to: "king_main#index"

  get '/(:user_id)', to: 'messages#index', as: "messages"
  post '/messages/(:user_id)', to: 'messages#create', as: "post_messages"
  get '/messages/:id/edit', to: 'messages#edit', as: 'edit_message'
  patch '/messages/:id', to: 'messages#update', as: "update_message"
  delete '/messages/:id', to: 'messages#destroy', as: "delete_message"

  root to: 'messages#index'


end
