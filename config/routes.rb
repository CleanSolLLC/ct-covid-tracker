Rails.application.routes.draw do
  
  get 'counties/show'
  #root to: "home#index"

  resources :states, only: [:index, :show, :new]
  
end
