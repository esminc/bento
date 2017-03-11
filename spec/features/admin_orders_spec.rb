require 'rails_helper'

RSpec.feature 'Admin::Orders', type: :feature do
  feature '管理者機能' do
    scenario '管理者はその日の注文を締め切ることが出来る' do
      visit admin_order_order_items_path(create(:order))

      expect(page).not_to have_text('注文締め切り時間')

      click_button('注文を締め切る')

      expect(page).to have_text('注文締め切り時間')
      expect(page).not_to have_selector('input[type=submit][value="注文を締め切る"]')
    end
  end
end

