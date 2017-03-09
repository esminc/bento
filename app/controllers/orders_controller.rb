class OrdersController < ApplicationController
  def index
    @orders = Order.on_weekday
  end
end
