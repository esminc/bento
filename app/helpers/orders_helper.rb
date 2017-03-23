module OrdersHelper
  def closed_info(order)
    "注文締め切り時間: #{l(order.closed_at)}"
  end

  def admin_order_items_title(date)
    if date == Time.current.to_date
      "今日（#{l(date)}）の注文一覧"
    else
      "#{l(date)}の注文一覧"
    end
  end
end
