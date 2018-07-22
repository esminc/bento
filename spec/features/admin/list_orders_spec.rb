require 'rails_helper'

RSpec.feature '注文可能日の一覧', type: :feature do
  given!(:order1) { create(:order, date: 'Thu, 1 Jun 2017', closed_at: nil) }
  given!(:order2) { create(:order, date: 'Fri, 2 Jun 2017', closed_at: nil) }
  given!(:order3) { create(:order, date: 'Mon, 5 Jun 2017', closed_at: nil) }


  scenario '日付を一覧表示できる' do
    Timecop.freeze(order1.date) do
      visit admin_orders_path

      expect(page).to have_text '2017/06/01(木)'
      expect(page).to have_text '2017/06/02(金)'
      expect(page).to have_text '2017/06/05(月)'
    end
  end

  scenario '特定の日付の注文を不可にすることができる' do
    visit admin_orders_path

    expect(Order.available.count).to eq(2)

    click_link '2017/06/01/(木) を注文不可日にする'

    expect(Order.available.count).to eq(2)
  end
end