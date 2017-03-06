Rails.application.routes.draw do
  resources :orders, only: %i(index) do
    resources :order_items, only: %i(new create show)
  end
end
