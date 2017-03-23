Rails.application.routes.draw do
  root 'orders#index'

  namespace :admin do
    resources :orders, only: %i() do
      member do
        patch :close
      end
      collection do
        get :todays_order, to: 'order_items#index'
      end
      resources :order_items, only: %i(index)
    end
  end

  resources :orders, only: %i(index) do
    resources :order_items, except: %i(show) do
      patch :receive
    end
  end
end
