Rails.application.routes.draw do

  
  
  root 'states#summary'

  devise_for :users

  resources :user do
  	resources :states, :only => [:new, :create, :index, :destroy] do 
      collection do
        delete :destroy_all
      end
    end

    resources :counties, :only => [:new, :create, :index, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :towns, :only => [:new, :create, :index, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :ethnic_cases, :only => [:new, :create, :index, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :age_groups, :only => [:new, :create, :index, :destroy] do
      collection do
        delete :destroy_all
      end
    end

    resources :gender_cases, :only => [:new, :create, :index, :destroy] do
      collection do
        delete :destroy_all
      end
    end
  end

   devise_scope :user do
   	 get 'users/sign_out', to: 'devise/sessions#destroy', as: 'logged_out'
   end

   get '/state/summary', to: 'states#summary'
end

  
