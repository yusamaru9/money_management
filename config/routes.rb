Rails.application.routes.draw do
  
  get 'users/show'
  root to: 'homes#top'
  resources :month_records
  resources :day_records do
    resources :comments, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :index, :destroy]
  end
  
  resources :month_records

  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
