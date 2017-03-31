require 'rails_helper'

RSpec.feature '予約の締め切り', type: :feature do
  given!(:order) { create(:order) }
  given!(:lunchbox) { create(:lunchbox) }

  scenario 'その日の予約を締め切る' do
    Timecop.freeze(order.date) do
      create(:order_item, lunchbox_id: lunchbox.id, order: order)
      create(:order_item, lunchbox_id: lunchbox.id, order: order)

      visit todays_order_admin_orders_path
      click_button('予約を締め切る')

      expect(page).to have_text('予約締め切り時間')
      expect(page).not_to have_selector('input[type=submit][value="予約を締め切る"]')
    end
  end
end
