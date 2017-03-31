require 'rails_helper'

RSpec.feature 'Order', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  feature '予約の新規作成' do
    scenario 'Order が締め切られている場合、予約者は新しく予約できない' do
      order = create(:order, :closed)
      visit new_order_order_item_path(order)

      expect(page).to have_text('受取確認')
    end

    scenario 'Order が締め切られている場合、予約者は新しい予約を確定できない' do
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

    scenario '予約者が新しく予約する' do
      visit order_order_items_path(order)
      user_name = 'sample-user'

      # NOTE: 未予約なことを確認
      expect(page).not_to have_text(user_name)

      click_link('予約する')
      fill_in '予約者名', with: user_name
      select lunchbox.name, from: 'order_item[lunchbox_id]'

      click_button '予約を確定する'

      # インデックスに戻る
      expect(page).to have_text(user_name)
      expect(page).to have_text('予約する')
      expect(page).to have_text('予約しました')
    end
  end

  feature '予約の受取' do
    given(:order) { create(:order, :closed) }

    scenario '予約者は自分の予約した弁当を受け取ったことをシステムに知らせることが出来る' do
      create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text('受取確認')

      click_link '受け取る'

      expect(page).to have_text('受け取り済')
    end
  end
end
