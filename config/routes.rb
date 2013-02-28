ExemploPassaporteWebRails32::Application.routes.draw do

  root :to => 'pages#public', :as => 'root'

  match '/private' => 'pages#private', :as => 'private'

  match '/auth/:provider/callback' => 'sessions#create'

  match '/auth/failure' => redirect('/')

  match '/logout' => 'sessions#destroy', :as => :logout
end
