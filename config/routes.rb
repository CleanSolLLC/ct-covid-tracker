Rails.application.routes.draw do

  root 'user#show'

  devise_for :users

  devise_scope :user do

  resources :user do
  	resources :states
  end
   get  'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
  end
  get '/state/summary', to: 'states#summary'
end

  
