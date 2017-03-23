class OrdersController < ApplicationController
  def index
    @orders = Order.available
  end
end
