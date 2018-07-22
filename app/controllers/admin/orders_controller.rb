require 'idobata'

class Admin::OrdersController < Admin::ApplicationController
  def index
    @orders = Order.available
  end

  def close
    order = Order.find(params[:id])

    order.close!
    message = if order.realized?
                "本日(#{I18n.l(order.date)})分の注文が成立しました:smiley:今日はお弁当があります:bento:"
              else
                "本日(#{I18n.l(order.date)})分の注文は成立しませんでした:cry:今日のランチは外に食べに行きましょう:fork_and_knife:"
              end
    Idobata.post(message, ENV['IDOBATA_USER_HOOK_URL']) if Rails.application.config.x.enable_idobata_notification

    redirect_to todays_order_admin_orders_path, notice: '予約を締め切りました'
  end
end
