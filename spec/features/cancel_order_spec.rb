require 'rails_helper'

RSpec.feature '予約のキャンセル', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  scenario '予約者は自分の予約をキャンセルできる' do
    order_item = create(:order_item, order: order, lunchbox: lunchbox)

    visit order_order_items_path(order)
    expect(page).to have_text(order_item.customer_name)
    expect(page).to have_text('予約取り消し')

    click_link('予約取り消し')
    expect(page).not_to have_text('予約取り消し')
    expect(page).to have_text("#{order_item.customer_name} さんの #{order_item.lunchbox.name} の予約を取り消しました。")
  end

  scenario '予約が締め切られている場合、予約者は自分の予約をキャンセルできない' do
    order = create(:order, :closed)
    create_list(:order_item, 2, order: order, lunchbox: lunchbox)
    order_item = create(:order_item, order: order, lunchbox: lunchbox)

    visit order_order_items_path(order)

    expect(page).to have_text(order_item.customer_name)
    expect(page).not_to have_link('予約取り消し')
  end
end
