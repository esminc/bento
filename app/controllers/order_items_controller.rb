class OrderItemsController < ApplicationController
  before_action :set_order_item, only: %i(show)

  def show
    # hogehoge
  end

  def new
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build(order_item_params)
    @order_item.lunchbox_id = lunchbox_params[:id]
    binding.pry

    if @order_item.save
      redirect_to [@order, @order_item], notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  private

    def set_order_item
      @order_item = OrderItem.find(params[:id])
    end

    def order_item_params
      params.require(:order_item).permit(:customer_name)
    end

    def lunchbox_params
      params.require(:lunchbox).permit(:id)
    end
end
