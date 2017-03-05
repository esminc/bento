Rails.application.routes.draw do
  resources :order_items, only: %i(new create show)
end
