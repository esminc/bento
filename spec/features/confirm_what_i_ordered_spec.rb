require 'rails_helper'

RSpec.feature '自分が予約した内容の確認', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  scenario '予約者は自分の予約を確認できる' do
    order_item = create(:order_item, order: order, lunchbox: lunchbox)

    visit order_order_items_path(order)
    expect(page).to have_text(order_item.customer_name)
    expect(page).to have_text('2017/02/01(水)の予約一覧')
  end
end
