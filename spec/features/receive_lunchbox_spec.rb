require 'rails_helper'

RSpec.feature '予約した弁当の受け取り', type: :feature do
  given!(:lunchbox) { create(:lunchbox) }
  given(:order) { create(:order) }

  feature '予約の受取' do
    given(:order) { create(:order, :closed) }

    scenario '予約した弁当を受け取ったことをシステムに登録する' do
      create(:order_item, order: order, lunchbox: lunchbox)

      visit order_order_items_path(order)
      expect(page).to have_text('受取確認')

      click_link '受け取る'

      expect(page).to have_text('受け取り済')
    end
  end
end
