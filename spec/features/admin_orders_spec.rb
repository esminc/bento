require 'rails_helper'

RSpec.feature 'Admin::Orders', type: :feature do

  before :each do
    admin_login
  end

  feature '管理者機能' do
    given!(:order) { create(:order) }

    scenario '管理者はその日の注文の数を見ることが出来る' do
      lunchbox = create(:lunchbox)
      create(:order_item, lunchbox_id: lunchbox.id, order: order)
      create(:order_item, lunchbox_id: lunchbox.id, order: order)

      visit admin_order_order_items_path(order)

      expect(page).to have_text(lunchbox.name)
      expect(page).to have_text(2)
      expect(page).to have_text(2 * lunchbox.price)
    end

    scenario '管理者はその日の注文を締め切ることが出来る' do
      visit admin_order_order_items_path(order)

      expect(page).not_to have_text('注文締め切り時間')

      click_button('注文を締め切る')

      expect(page).to have_text('注文締め切り時間')
      expect(page).not_to have_selector('input[type=submit][value="注文を締め切る"]')
    end
  end
end

