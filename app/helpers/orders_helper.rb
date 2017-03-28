module OrdersHelper
  def closed_info(order)
    "#{Order.human_attribute_name(:closed_at)}: #{l(order.closed_at)}"
  end

  def order_items_title(date)
    if date == Time.current.to_date
      "今日（#{l(date)}）の注文一覧"
    else
      "#{l(date)}の注文一覧"
    end
  end
end
