require 'rails_helper'

RSpec.feature '予約の修正', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  scenario '予約者は自分の予約を修正できる' do
    other_lunchbox = create(:lunchbox, name: 'sample弁当-上')
    order_item = create(:order_item, order: order, lunchbox: lunchbox)
    new_name = 'another_name'
    new_lunchbox_tag = "#{other_lunchbox.name} (#{other_lunchbox.price}円)"

    visit order_order_items_path(order)
    expect(page).to have_text(order_item.customer_name)

    click_link(order_item.customer_name)
    fill_in '予約者名', with: new_name

    expect(page).to have_select('order_item[lunchbox_id]', selected: "#{lunchbox.name} (#{lunchbox.price}円)")
    select new_lunchbox_tag, from: 'order_item[lunchbox_id]'

    click_button '予約を確定する'

    expect(page).not_to have_text(order_item.customer_name)
    expect(page).to have_text(new_name)

    click_link(new_name)
    expect(page).to have_select('order_item[lunchbox_id]', selected: new_lunchbox_tag)
  end

  scenario '予約が締め切られている場合、予約者は自分の予約を編集できない' do
    order_items = create_list(:order_item, 3, order: order, lunchbox: lunchbox)
    order.close!

    visit order_order_items_path(order)

    expect(page).not_to have_link(order_items[0].customer_name)
  end
end
