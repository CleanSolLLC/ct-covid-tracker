Rails.application.routes.draw do
  #get 'counties/show'

get '/ct_user/:id', to: 'ct_user#home'
  #resources :states, only: [:index, :show, :new]
  
  resources :ct_user do
  	resources :states, only: [:index, :show]
  end
end
