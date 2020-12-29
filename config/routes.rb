Rails.application.routes.draw do

  
  
  root 'user#show'

  devise_for :users

  resources :user do
  	resources :states
    resources :ethnic_cases
    resources :age_groups
    resources :gender_cases
  end

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

   get '/state/summary', to: 'states#summary'
end

  
