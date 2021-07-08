Rails.application.routes.draw do

  
  root 'states#summary'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }


    match '/404', via: :all, to: 'errors#not_found'
    match '/422', via: :all, to: 'errors#unprocessable_entity'
    match '/500', via: :all, to: 'errors#server_error'

    match 'users/:id' => 'user#destroy', :via => :delete, :as => :destroy_user


  shallow do
    resources :user do
      resources :states, :only => [:new, :create, :index, :destroy]
      resources :counties, :only => [:new, :create, :index, :show, :destroy]
      resources :towns, :only => [:new, :create, :index, :destroy]
      resources :ethnic_cases, :only => [:new, :create, :index, :destroy]
      resources :age_groups, :only => [:new, :create, :index, :destroy]
      resources :gender_cases, :only => [:new, :create, :index, :destroy] 

      resources :states, :counties, :towns, :ethnic_cases, :age_groups, :gender_cases do
        collection do 
          delete :destroy_all
        end
      end

   get '/chart/state_rates', to: 'charts#state_rates'
   get '/chart/state_tests', to: 'charts#state_tests' 
    
    end 
  end

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

    resources :posts do
      resources :comments, :only => [:create, :edit, :update]
      get 'posts/:id/comments/:id', to: 'comments#destroy', as: 'delete_comment'
    end

   get '/state/summary', to: 'states#summary'




   
 end

  
