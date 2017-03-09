Rails.application.routes.draw do
  root 'orders#index'

  namespace :admin do
    resources :orders, only: %i() do
      patch :close
      resources :order_items, only: %i(index)
    end
  end

  resources :orders, only: %i(index) do
    resources :order_items, except: %i(show) do
      patch :receive
    end
  end
end
