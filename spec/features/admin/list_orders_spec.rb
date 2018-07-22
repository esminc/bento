require 'rails_helper'

RSpec.feature '注文可能日の一覧', type: :feature do
  given(:order1) { create(:order, date: 'Thu, 1 Jun 2017', closed_at: nil) }
  given!(:order2) { create(:order, date: 'Fri, 2 Jun 2017', closed_at: nil) }
  given!(:order3) { create(:order, date: 'Mon, 5 Jun 2017', closed_at: nil) }


  scenario '日付を一覧表示できる' do
    visit admin_orders_path

    expect(page).to have_text '2017/01/01/(木)'
    expect(page).to have_text '2017/01/02/(金)'
    expect(page).to have_text '2017/01/05/(月)'
  end

  scenario '特定の日付を締め切ることができる' do
    visit admin_orders_path

    expect(Order.available.count).to eq(2)

    click_link '締め切る', match: :first

    expect(Order.available.count).to eq(2)
  end
end