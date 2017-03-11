module OrdersHelper
  def closed_info(order)
    "注文締め切り時間: #{I18n.l(order.closed_at)}"
  end
end
