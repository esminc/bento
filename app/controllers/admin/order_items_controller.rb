class Admin::OrderItemsController < Admin::ApplicationController
  def index
    @order = Order.find_by(date: Time.current.to_date)

    @matrix = OrderItemsMatrix.new(@order.date).generate
  end
end
