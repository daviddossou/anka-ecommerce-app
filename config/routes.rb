Rails.application.routes.draw do
  get 'orders/create'
  get 'orders/show'
  get 'products/index'
  get 'products/show'
  resources :products, only: %i[index show]
  resources :orders, only: %i[create show]
  namespace :webhooks do
    get 'anka_pay/receive'
    post :anka_pay, to: 'anka_pay#receive'
  end
  root 'products#index'
end
