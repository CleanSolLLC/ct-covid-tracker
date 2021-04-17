Rails.application.routes.draw do

  
  root 'states#summary'

  devise_for :users

   match '/404', via: :all, to: 'errors#not_found'
   match '/422', via: :all, to: 'errors#unprocessable_entity'
   match '/500', via: :all, to: 'errors#server_error'

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

  
