require 'rails_helper'

RSpec.feature "Order::OrderItems", type: :feature do

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
      expect(page).to have_text("cancel")

      click_link('cancel')
      expect(page).not_to have_text(order_item.customer_name)

    end
  end


  feature '注文の修正' do
    scenario '注文者は自分の注文を修正できる' do
      create(:lunchbox)
      create(:good_lunchbox)
      order = create(:order)
      order_item = create(:order_item)
      new_name = "another_name"

      visit order_order_items_path(order)
      expect(page).to have_text(order_item.customer_name)

      # edit name
      click_link(order_item.customer_name)
      expect(find_field('Customer name').value).to eq order_item.customer_name
      fill_in "Customer name", with:new_name

      # change lunchbox
      expect(page).to have_select("order_item[lunchbox_id]",selected: "normal")
      select "good", from: "order_item[lunchbox_id]"

      # text(order_item.customer_name)

      # update confirm
      click_button "Update Order item"
      expect(page).not_to have_text(order_item.customer_name)
      expect(page).not_to have_text("hoge")
      expect(page).to have_text(new_name)

      # confirm new order in edit page
      click_link(new_name)
      expect(page).to have_select("order_item[lunchbox_id]",selected: "good")

    end
  end

end


