class Admin::OrderItemsController < Admin::ApplicationController
  def index
    @order = Order.find_by(date: Date.current)
    @lunchboxes = Lunchbox.all
    @aggregate_order_items = @order.aggregate_items(@lunchboxes)
  end
end
