require 'rails_helper'

RSpec.feature '発注者へのメッセージを表示する', type: :feature do
  given!(:order) { create(:order) }
  given!(:jouben_dai) { create(:lunchbox, name: '上弁ライス大') }
  given!(:tokuben_futsuu) { create(:lunchbox, name: '特弁ライス普') }
  given(:order_needed_message) { '本日のお弁当の注文をお願いします。' }
  given(:order_unneeded_message) { '本日のお弁当の注文は不要です。' }

  context '当日の予約を締め切る前' do
    background do
      Timecop.freeze(order.date) do
        create_list(:order_item, 2, lunchbox: jouben_dai, order: order)
        create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order)
      end
    end

    it 'メッセージは表示されていない' do
      Timecop.freeze(order.date) do
        visit todays_order_admin_orders_path

        expect(page).not_to have_text order_needed_message
      end
    end
  end

  context '当日の予約を締め切った後' do
    context '予約が成立したとき' do
      background do
        Timecop.freeze(order.date) do
          create_list(:order_item, 2, lunchbox: jouben_dai, order: order)
          create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order)
        end
      end

      it '発注をお願いする旨のメッセージが表示される' do
        Timecop.freeze(order.date) do
          visit todays_order_admin_orders_path
          click_button('予約を締め切る')

          within '.order-message' do
            expect(page).to have_text order_needed_message
          end
        end
      end
    end

    context '予約が不成立だったとき' do
      it '発注が不要な旨のメッセージが表示される' do
        Timecop.freeze(order.date) do
          visit todays_order_admin_orders_path
          click_button('予約を締め切る')

          within '.order-message' do
            expect(page).to have_text order_unneeded_message
          end
        end
      end
    end
  end
end
