require 'idobata'

class Admin::OrdersController < Admin::ApplicationController
  def close
    order = Order.find(params[:id])
    order.close!

    # TODO: 例外を入れる PR がマージされたら、ここを realized? で書き換える
    if order.item_count_satisfied?
      Idobata.post_for_user "本日(#{I18n.l(order.date)})分の注文が成立しました:smiley:今日はお弁当があります:bento:"
    else
      Idobata.post_for_user "本日(#{I18n.l(order.date)})分の注文は成立しませんでした:cry:今日のランチは外に食べに行きましょう:fork_and_knife:"
    end

    redirect_to todays_order_admin_orders_path, notice: '予約を締め切りました'
  end
end
