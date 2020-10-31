Rails.application.routes.draw do
  
  #root to: "home#index"

  resources :states, only: [:index, :show, :new]
  
end
