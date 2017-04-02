module Admin::OrderItemsHelper
  def admin_thead(lunchboxes)
    header = [''] + lunchboxes.pluck(:name) + ['合計']

    create_row(:th, header)
  end

  def admin_tbody(item_numbers, item_prices)
    number_body = ['個数'] + item_numbers
    price_body = ['合計'] + item_prices

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
