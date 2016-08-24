Rails.application.routes.draw do

  
  devise_for :users
  root 'welcome#index'

  resources :articles do
  	resources :comments, only: [:create, :destroy, :update]
  end
  #resources :articles, except: [:delete]
  #resources :articles, only: [:create, :show]
  #get 'special', to: "welcome#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
