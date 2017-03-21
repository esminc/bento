require 'rails_helper'

RSpec.feature 'Order', type: :feature do
  given(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  feature '注文の確認' do
    scenario '注文者は自分の注文を確認できる' do
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)
      expect(page).to have_text('予約確認・注文確認')
    end
  end

  feature '注文のキャンセル' do
    scenario '注文者は自分の注文をキャンセルできる' do
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)
      expect(page).to have_text('cancel')

      click_link('cancel')
      expect(page).not_to have_text(order_item.customer_name)

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

      # edit name
      click_link(order_item.customer_name)
      fill_in 'Customer name', with: new_name

      # change lunchbox
      expect(page).to have_select('order_item[lunchbox_id]',selected: lunchbox.name)
      select new_lunchbox_name, from: 'order_item[lunchbox_id]'

      # update confirm
      click_button 'Update Order item'
      expect(page).not_to have_text(order_item.customer_name)
      expect(page).to have_text(new_name)

      # confirm new order in edit page
      click_link(new_name)
      expect(page).to have_select('order_item[lunchbox_id]',selected: new_lunchbox_name)
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
