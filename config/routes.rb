Rails.application.routes.draw do
  #get 'counties/show'

get '/ct_user/:id', to: 'ct_user#home'
  #resources :states, only: [:index, :show, :new]
  
  resources :ct_user do
  	resources :states, only: [:index, :show]
  end
end


# Rails.application.routes.draw do
# root 'ct_user#home'

# get 
# get 'ct_user/states/:id', to: 'states#show'

# end

  # resources :ct_users do
  # 	resources :states
  # end

  # get 'states/:id', to: 'states#show'

#end

  #get 'ct_user/:id/states/:id', to: 'states#show'





#resources :states, only: [:index, :show, :new]
  
