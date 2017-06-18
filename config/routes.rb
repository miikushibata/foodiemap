Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :new, :create] do
   member do
     get :map
     get :visit_list
     get :interest_list
   end
 end
  
  #h resources :restaurants, only: [:show, :new, :create]
  resources :restaurants, only: [:index, :show]
  resources :rest_favorites, only: [:create, :destroy]
  
  resources :reviews, only: [:create, :destroy]
end
