Rails.application.routes.draw do

  
  
  root 'states#summary'

  devise_for :users

  resources :user do
  	resources :states, :only => [:new, :create, :index, :destroy]
    resources :counties, :only => [:new, :create, :index, :destroy]
    resources :towns, :only => [:new, :create, :index]
    resources :ethnic_cases, :only => [:new, :create, :index], :only => [:new, :create, :index]
    resources :age_groups, :only => [:new, :create, :index]
    resources :gender_cases, :only => [:new, :create, :index]
  end

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

   get '/state/summary', to: 'states#summary'
end

  
