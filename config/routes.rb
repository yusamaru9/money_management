Rails.application.routes.draw do
  
  devise_for :users
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  root to: 'homes#top'
  resources :users, only: [:show]
  resources :month_records, except: [:destroy] do
    collection do
      get '/bookmarks' => 'month_records#bookmarks'
    end
  end
  get '/day_genres' => 'day_records#day_genres'
  resources :day_records, except: [:destroy] do
    resources :day_comments, only: [:create, :destroy]
    resource :bookmarks, only: [:create, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
