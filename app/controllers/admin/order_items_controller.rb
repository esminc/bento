class Admin::OrderItemsController < Admin::ApplicationController
  def index
    @order = Order.find(params[:order_id])

    @matrix = OrderItemsMatrix.new(@order.date).generate
  end
end
