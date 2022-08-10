Rails.application.routes.draw do
  get 'bookmarks/index'
  get 'day_records/index'
  get 'day_records/new'
  get 'day_records/show'
  get 'day_records/edit'
  get 'month_records/index'
  get 'month_records/new'
  get 'month_records/show'
  get 'month_records/edit'
  root to: 'homes#top'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
