module Admin::OrderItemsHelper
  def admin_thead(lunchboxes)
    header = [''] + lunchboxes.pluck(:name) + ['合計']

    create_row(:th, header)
  end

  def admin_tbody(aggregate_order_items)
    number_body = ['個数'] + aggregate_order_items[0]
    price_body = ['合計'] + aggregate_order_items[1]

    create_row(:td, number_body) + create_row(:td, price_body)
  end

  private

  def create_row(t, texts)
    content_tag(:tr) do
      texts.each do |text|
        concat content_tag(t, text)
      end
    end
  end
end
