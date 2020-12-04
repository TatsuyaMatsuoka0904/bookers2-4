Rails.application.routes.draw do
 devise_for :users
 root "homes#top"
 get "home/about" => "homes#about", as: :about
 
 resources :users, only: [:index, :show, :edit, :update] do
  member do
   get :following, :followers
  end
 end
 
  post 'follow/:id' => 'relationships#create', as: 'follow'
  post 'unfollow/:id' => 'relationships#destroy', as: 'unfollow'
 resources :books do
  
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
 end
 
end
