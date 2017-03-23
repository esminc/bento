require 'rails_helper'

RSpec.feature 'Order', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  feature '注文の確認' do
    scenario '注文者は自分の注文を確認できる' do
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)
      expect(page).to have_text('予約確認・注文確認')
    end
  end

  feature '注文の新規作成' do

    scenario 'Order が締め切られている場合、注文者は新しく注文できない' do
      order = create(:order, :closed)
      visit new_order_order_item_path(order)

      expect(page).to have_text('受取確認')
    end

    scenario 'Order が締め切られている場合、注文者は新しい注文を確定できない' do
      user_name = 'sample-user'

      visit order_order_items_path(order)

      # NOTE: 未予約なことを確認
      expect(page).not_to have_text(user_name)

      click_link('予約する')
      fill_in 'Customer name', with: 'customer'
      select lunchbox.name, from: 'order_item[lunchbox_id]'

      order.close(Time.zone.local(2017, 2, 1))

      click_button 'Create Order item'
      # インデックスに戻され、予約は確定できていない
      expect(page).not_to have_text(user_name)
      expect(page).to have_text('受取確認')

    end

    scenario '注文者が新しく注文する' do

      visit order_order_items_path(order)
      user_name = 'sample-user'

      # NOTE: 未予約なことを確認
      expect(page).not_to have_text(user_name)

      click_link('予約する')
      fill_in 'Customer name', with: user_name
      select lunchbox.name, from: 'order_item[lunchbox_id]'

      click_button 'Create Order item'

      # インデックスに戻る
      expect(page).to have_text(user_name)
      expect(page).to have_text('予約する')
      expect(page).to have_text('注文しました')

    end
  end

  feature '注文のキャンセル' do
    scenario '注文者は自分の注文をキャンセルできる' do
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)
      expect(page).to have_text('予約取り消し')

      click_link('予約取り消し')
      expect(page).not_to have_text('予約取り消し')
      expect(page).to have_text("#{order_item.customer_name} さんの #{order_item.lunchbox.name} の注文を取り消しました。")
    end

    scenario 'Order が締め切られている場合、注文者は自分の注文をキャンセルできない' do
      order = create(:order, :closed)
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)

      expect(page).to have_text(order_item.customer_name)
      expect(page).not_to have_link('予約取り消し')
      expect(page).not_to have_text("#{order_item.customer_name}'s' #{order_item.lunchbox.name} item was successfully deleted.")
    end

  end


  feature '注文の修正' do
    scenario '注文者は自分の注文を修正できる' do
      create(:lunchbox, name: 'sample弁当-上')
      order_item = create(:order_item, order: order, lunchbox: lunchbox)
      new_name = 'another_name'
      new_lunchbox_name = 'sample弁当-上'

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)

      click_link(order_item.customer_name)
      fill_in 'Customer name', with: new_name

      expect(page).to have_select('order_item[lunchbox_id]',selected: lunchbox.name)
      select new_lunchbox_name, from: 'order_item[lunchbox_id]'

      click_button 'Update Order item'
      expect(page).not_to have_text(order_item.customer_name)
      expect(page).to have_text(new_name)

      click_link(new_name)
      expect(page).to have_select('order_item[lunchbox_id]',selected: new_lunchbox_name)
    end

    scenario 'Order が締め切られている場合、注文者は自分の注文を編集できない' do
      order = create(:order, :closed)
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)

      expect(page).not_to have_link(order_item.customer_name)
    end

  end

  feature '注文の受取' do
    given(:order) { create(:order, :closed) }

    scenario '注文者は自分の注文した弁当を受け取ったことをシステムに知らせることが出来る' do
      order_items = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text('受取確認')

      click_link '受け取る'

      expect(page).to have_text('受け取り済')
    end
  end
end
