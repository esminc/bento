require 'rails_helper'

RSpec.feature 'Order', type: :feature do

  feature '注文の確認' do
    scenario '注文者は自分の注文を確認できる' do
      lunchbox = create(:lunchbox)
      order = create(:order)
      order_item = create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)
    end
  end

  feature '注文のキャンセル' do
    scenario '注文者は自分の注文をキャンセルできる' do
      lunchbox = create(:lunchbox)
      order = create(:order)
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
      lunchbox = create(:lunchbox)
      create(:lunchbox, name: 'sample弁当-上')
      order = create(:order)
      order_item = create(:order_item, order: order, lunchbox: lunchbox)
      new_name = 'another_name'
      new_lunchbox_name = 'sample弁当-上'

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)

      # edit name
      click_link(order_item.customer_name)
      fill_in 'Customer name', with: new_name

      # change lunchbox
      expect(page).to have_select('order_item[lunchbox_id]',selected: 'sample弁当')
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

end


