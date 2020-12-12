Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do

  resources :user do
  	resources :states
  end
   get  'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
  end

  root 'site#welcome'

  
end

  
