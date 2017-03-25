require 'rails_helper'

RSpec.feature 'Admin::Orders', type: :feature do

  before :each do
    admin_login
  end

  feature '管理者機能' do
    given!(:order) { create(:order) }
    given!(:lunchbox) { create(:lunchbox) }

    scenario '固定のURLで今日の予約状況を見れて、注文を締めることが出来る' do
      Timecop.freeze(order.date) do
        create(:order_item, lunchbox_id: lunchbox.id, order: order)
        create(:order_item, lunchbox_id: lunchbox.id, order: order)

        visit todays_order_admin_orders_path

        expect(page).to have_text("今日（#{I18n.l(order.date)}）の注文一覧")
        expect(page).to have_text(lunchbox.name)
        expect(page).to have_text(2) # NOTE: 個数が表示される
        expect(page).to have_text(2 * lunchbox.price)

        expect(page).not_to have_text('注文締め切り時間')

        click_button('注文を締め切る')

        expect(page).to have_text('注文締め切り時間')
        expect(page).not_to have_selector('input[type=submit][value="注文を締め切る"]')
      end
    end
  end
end
