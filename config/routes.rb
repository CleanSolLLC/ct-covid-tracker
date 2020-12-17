Rails.application.routes.draw do

  
  root 'user#show'

  devise_for :users

  resources :user do
  	resources :states
  end

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

   get '/state/summary', to: 'states#summary'
end

  
