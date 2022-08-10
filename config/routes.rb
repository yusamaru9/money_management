Rails.application.routes.draw do
  
  devise_for :users
  
  get 'users/show'
  root to: 'homes#top'
  resources :month_records, except: [:destroy]
  resources :day_records, except: [:destroy] do
    resources :comments, only: [:create, :destroy]
    resources :bookmarks, only: [:create, :index, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
