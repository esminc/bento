Rails.application.routes.draw do
  namespace :admin do
    resources :orders, only: %i(show) do
      patch :submit
    end
  end

  resources :orders, only: %i(index show) do
    get :confirm

    resources :order_items, only: %i(new create edit update destroy) do
      patch :receive
    end
  end
end
