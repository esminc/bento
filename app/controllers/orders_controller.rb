class OrdersController < ApplicationController
  def index
    @orders = Order.where('date > ?', Time.current).limit(Order::SHOW_COUNT).order(date: :asc)
  end
end
