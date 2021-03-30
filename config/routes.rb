Rails.application.routes.draw do

  
  
  root 'user#show'

  devise_for :users

  resources :user do
  	resources :states, :only => [:new, :create, :index]
    resources :counties, :only => [:new, :create, :index]
    resources :towns, :only => [:new, :create, :index]
    resources :ethnic_cases, :only => [:new, :create, :index], :only => [:new, :create, :index]
    resources :age_groups, :only => [:new, :create, :index]
    resources :gender_cases, :only => [:new, :create, :index]
  end

  get '/user/:id/states/:id', to: 'states#destroy', as: 'destroy_state'

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

   get '/state/summary', to: 'states#summary'
end

  
