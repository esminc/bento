require 'rails_helper'

RSpec.feature '予約数が規定の数に足りない時', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  feature '確定された場合' do
    before(:each) do
      Timecop.freeze(order.date) do
        create_list(:order_item, 2, order: order, lunchbox: lunchbox)
        order.close!(Time.zone.local(2017, 2, 1))
      end
    end

    scenario 'トップページにメッセージが表示される' do
      Timecop.freeze(order.date) do
        visit orders_path
        expect(page).to have_text('注文数不足のため注文されませんでした')
      end
    end

    scenario '注文の確認画面へ遷移しようとするとトップページに戻される' do
      Timecop.freeze(order.date) do
        visit order_order_items_path(order)
        expect(page).to have_text('注文数不足のため注文されませんでした')
      end
    end
  end
end
