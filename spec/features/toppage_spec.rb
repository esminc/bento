require 'rails_helper'

RSpec.feature '注文の成立・非成立がトップページに表示される', type: :feature do
  let(:jouben_dai) { create(:lunchbox, name: '上弁ライス大') }
  let(:tokuben_futsuu) { create(:lunchbox, name: '特弁ライス普') }
  let(:order) { create(:order, date: 'Thu, 1 Jun 2017') }

  context '締め切り前' do
    scenario '注文の成立に関するメッセージは表示されない' do
      Timecop.freeze(order.date) do
        create_list(:order_item, 2, lunchbox: jouben_dai, order: order)
        create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order)

        visit root_path

        expect(page).not_to have_content '本日の予約は締め切りました。受け取りチェックをするには以下のリンクをクリックしてください。'
      end
    end

    scenario '注文の非成立に関するメッセージは表示されない' do
      Timecop.freeze(order.date) do
        create_list(:order_item, 1, lunchbox: jouben_dai, order: order)
        create_list(:order_item, 1, lunchbox: tokuben_futsuu, order: order)

        visit root_path

        # TODO アプリ側の文言を、注文 -> 予約にする
        expect(page).not_to have_content '本日 (2017/06/01(木)) の発注は注文数不足のため注文されませんでした'
      end
    end
  end

  context '締め切り後' do
    background do
      Timecop.freeze(order.date) do
        visit todays_order_admin_orders_path
        click_button('予約を締め切る')
      end
    end

    scenario '成立数に達していたら、注文の成立に関するメッセージが表示される' do
      Timecop.freeze(order.date) do
        create_list(:order_item, 2, lunchbox: jouben_dai, order: order)
        create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order)

        visit root_path

        expect(page).to have_content '本日の予約は締め切りました。受け取りチェックをするには以下のリンクをクリックしてください。'
      end
    end

    scenario '成立数に達していなかったら、注文の非成立に関するメッセージが表示される' do
      Timecop.freeze(order.date) do
        create_list(:order_item, 1, lunchbox: jouben_dai, order: order)
        create_list(:order_item, 1, lunchbox: tokuben_futsuu, order: order)

        visit root_path

        # TODO アプリ側の文言を、注文 -> 予約にする
        expect(page).to have_content '本日 (2017/06/01(木)) の発注は注文数不足のため注文されませんでした'
      end
    end
  end
end
