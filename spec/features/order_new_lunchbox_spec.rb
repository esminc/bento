require 'rails_helper'

RSpec.feature '新たに弁当を予約する', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  scenario '新しく予約する' do
    visit order_order_items_path(order)
    user_name = 'sample-user'

    # NOTE: 未予約なことを確認
    expect(page).not_to have_text(user_name)

    click_link('予約する')
    fill_in '予約者名', with: user_name
    select lunchbox.name, from: 'order_item[lunchbox_id]'

    click_button '予約を確定する'

    expect(page).to have_text(user_name)
    expect(page).to have_text('予約する')
    expect(page).to have_text('予約しました')
  end

  context '予約が締め切られている場合' do
    scenario '新しく予約できない' do
      order = create(:order, :closed)
      create_list(:order_item, 3, order: order, lunchbox: lunchbox)
      visit new_order_order_item_path(order)

      expect(page).to have_text('受取確認')
    end

    scenario '新しい予約を確定できない' do
      create_list(:order_item, 3, order: order, lunchbox: lunchbox)
      user_name = 'sample-user'

      visit order_order_items_path(order)

      # NOTE: 未予約なことを確認
      expect(page).not_to have_text(user_name)

      click_link('予約する')
      fill_in '予約者名', with: 'customer'
      select lunchbox.name, from: 'order_item[lunchbox_id]'

      order.close(Time.zone.local(2017, 2, 1))

      click_button '予約を確定する'

      expect(page).not_to have_text(user_name)
      expect(page).to have_text('予約受付が締め切られたため予約できません')
      expect(page).to have_text('受取確認')
    end

  end
end
