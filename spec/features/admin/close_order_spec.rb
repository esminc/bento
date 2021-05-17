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

  scenario 'すでに注文の締め切り処理が終わっている場合は予約を締め切れない' do
    # TODO 今回あったように日付をまたいだケースを作りたい。
    order = create(:order, date: 'Mon, 29 May 2017')
    Timecop.freeze(order.date) do
      create(:order_item, lunchbox_id: lunchbox.id, order: order)
      create(:order_item, lunchbox_id: lunchbox.id, order: order)

      visit todays_order_admin_orders_path

      using_session SecureRandom.uuid do
        visit todays_order_admin_orders_path
        click_button('予約を締め切る')
      end

      click_button('予約を締め切る')

      expect(page).to have_content '2017/05/29(月)はすでに締め切り処理が済んでいます'
      within 'h1' do
        expect(page).to have_content '今日（2017/05/29(月)）の予約一覧'
      end
    end
  end
end
