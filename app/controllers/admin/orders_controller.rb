class Admin::OrdersController < Admin::ApplicationController
  def close
    order = Order.find(params[:id])

    if order.close
      redirect_to todays_order_admin_orders_path, notice: '注文を締め切りました'
    else
      redirect_to todays_order_admin_orders_path, alert: '注文を締め切れませんでした'
    end
  end
end
