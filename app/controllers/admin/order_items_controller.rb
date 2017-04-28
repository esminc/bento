class Admin::OrderItemsController < Admin::ApplicationController
  def index
    @order = Order.find_by(date: Date.current)
    @lunchboxes = Lunchbox.all
    @item_numbers, @item_prices = @order.aggregate_items(@lunchboxes)
  end
end
