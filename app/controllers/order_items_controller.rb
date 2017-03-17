class OrderItemsController < ApplicationController
  def index
    # 予約確認・受取確認
    @order = Order.find(params["order_id"])

    if @order.closed_at?
      render 'receive'
    else
      render 'index'
    end
  end

  def new
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build
  end

  def create
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      redirect_to order_order_items_path(@order) , notice: 'Order item was successfully created.'
    else
      render :new
    end
  end

  def edit
    # 弁当注文編集画面
    @order = Order.find(params[:order_id])
    @order_item = OrderItem.find(params[:id])
  end

  def update
    # 弁当注文編集
    @order_item = OrderItem.find(params[:id])
    if @order_item.update(order_item_params)
      redirect_to order_order_items_path(@order_item.order)
    else
      render :edit
    end
  end

  def destroy
    # 弁当注文削除
    order_item = OrderItem.find(params[:id]).destroy
    if order_item
      notice = "#{order_item.customer_name}'s' #{order_item.lunchbox.name} item was successfully deleted."
      redirect_to order_order_items_path(order_item.order) , notice: notice
    end
  end

  def receive
    # 注文を受け取る
  end

  private

  def order_item_params
    params.require(:order_item).permit(:customer_name, :lunchbox_id)
  end

end
