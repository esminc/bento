class OrderItemsController < ApplicationController
  before_action :set_order, except: :receive
  before_action :order_close_confirmation, only: %i(new create edit destroy)
  before_action :set_order_item, only: %i(edit update destroy receive)

  def index
    if @order.closed?
      render 'receive'
    else
      render 'index'
    end
  end

  def new
    @order_item = @order.order_items.build
  end

  def create
    @order_item = @order.order_items.build(order_item_params)

    if @order_item.save
      redirect_to order_order_items_path(@order) , notice: '注文しました'
    else
      flash[:error] = @order_item.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    if @order_item.update(order_item_params)
      redirect_to order_order_items_path(@order_item.order)
    else
      flash[:error] = @order_item.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    @order_item.destroy
    if @order_item
      notice = "#{@order_item.customer_name} さんの #{@order_item.lunchbox.name} の注文を取り消しました。"
      redirect_to order_order_items_path(@order_item.order) , notice: notice
    end
  end

  def receive
    if @order_item.update(received_at: Time.current)
      redirect_to order_order_items_path(@order_item.order) , notice: '注文した弁当を受け取りました'
    else
      redirect_to order_order_items_path(@order_item.order) , alert: '予期せぬエラーが発生しました'
    end
  end

  private

  def set_order
    @order = Order.find(params[:order_id])
  end

  def order_close_confirmation
    notice = "it is too late."
    redirect_to order_order_items_path(@order) , notice: notice if @order.closed_at
    return
  end

  def set_order_item
    @order_item = OrderItem.find(params[:id])
  end

  def order_item_params
    params.require(:order_item).permit(:customer_name, :lunchbox_id)
  end

  def lunchbox_params
    params.require(:lunchbox).permit(:id)
  end
end
