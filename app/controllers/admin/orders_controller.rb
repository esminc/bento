class Admin::OrdersController < Admin::ApplicationController
  def today
    @order = Order.find_by(date: Time.current.to_date)

    if @order
      @matrix = OrderItemsMatrix.new(@order.date).generate
      render 'admin/order_items/index'
    else
      redirect_to orders_path, alert: '注文が存在していません'
    end
  end

  def close
    order = Order.find(params[:id])

    if order.update(closed_at: Time.zone.now)
      redirect_to admin_order_order_items_path(order), notice: '注文を締め切りました'
    else
      redirect_to admin_order_order_items_path(order), alert: '注文を締め切れませんでした'
    end
  end
end
