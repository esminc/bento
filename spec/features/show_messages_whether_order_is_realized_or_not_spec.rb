require 'rails_helper'

RSpec.feature '予約を締め切ったあとには、注文の成立・非成立を知らせるメッセージがトップページに表示される', type: :feature do
  let(:jouben_dai) { create(:lunchbox, name: '上弁ライス大') }
  let(:tokuben_futsuu) { create(:lunchbox, name: '特弁ライス普') }
  let(:order1) { create(:order, date: 'Thu, 1 Jun 2017', closed_at: nil) }
  let!(:order2) { create(:order, date: 'Fri, 2 Jun 2017', closed_at: nil) }
  let!(:order3) { create(:order, date: 'Mon, 5 Jun 2017', closed_at: nil) }

  context '締め切り前' do
    context '成立数に達していたとき' do
      scenario '注文の成立に関するメッセージは表示されない' do
        Timecop.freeze(order1.date) do
          create_list(:order_item, 2, lunchbox: jouben_dai, order: order1)
          create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order1)

          visit root_path

          expect(page).not_to have_content '本日の予約は締め切りました。受け取りチェックをするには以下のリンクをクリックしてください。'
          expect(page).not_to have_content '本日 (2017/06/01(木)) の発注は注文数不足のため注文されませんでした'
        end
      end
    end

    context '成立数に達していなかったとき' do
      scenario '注文の成立に関するメッセージは表示されない' do
        Timecop.freeze(order1.date) do
          create_list(:order_item, 1, lunchbox: jouben_dai, order: order1)
          create_list(:order_item, 1, lunchbox: tokuben_futsuu, order: order1)

          visit root_path

          expect(page).not_to have_content '本日の予約は締め切りました。受け取りチェックをするには以下のリンクをクリックしてください。'
          expect(page).not_to have_content '本日 (2017/06/01(木)) の発注は注文数不足のため注文されませんでした'
        end
      end
    end
  end

  context '締め切り後' do
    background do
      Timecop.freeze(order1.date) do
        visit todays_order_admin_orders_path
        click_button('予約を締め切る')
      end
    end

    context '成立数に達していたとき' do
      scenario '注文の成立を知らせるメッセージが表示される' do
        Timecop.freeze(order1.date) do
          create_list(:order_item, 2, lunchbox: jouben_dai, order: order1)
          create_list(:order_item, 3, lunchbox: tokuben_futsuu, order: order1)

          visit root_path

          expect(page).to have_content '本日の予約は締め切りました。受け取りチェックをするには以下のリンクをクリックしてください。'
        end
      end
    end

    context '成立数に達していなかったとき' do
      scenario '注文の非成立を知らせるメッセージが表示される' do
        Timecop.freeze(order1.date) do
          create_list(:order_item, 1, lunchbox: jouben_dai, order: order1)
          create_list(:order_item, 1, lunchbox: tokuben_futsuu, order: order1)

          visit root_path

          expect(page).to have_content '本日 (2017/06/01(木)) は予約数不足のため注文されませんでした'
        end
      end
    end
  end
end
