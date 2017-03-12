class OrderItemsController < ApplicationController
  def index
    # 予約確認・受取確認

    @order = Order.find(params["order_id"])

  end

  def new
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build(order_item_params)
    @order_item.lunchbox_id = lunchbox_params[:id]

    if @order_item.save
      redirect_to order_order_items_path(@order) , notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def edit
    # 弁当注文編集画面
  end

  def update
    # 弁当注文編集
  end

  def destroy
    # 弁当注文削除
  end

  def receive
    # 注文を受け取る
  end

  private

  def order_item_params
    params.require(:order_item).permit(:customer_name)
  end

  def lunchbox_params
    params.require(:lunchbox).permit(:id)
  end
end
