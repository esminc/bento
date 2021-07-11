require 'rails_helper'

RSpec.feature '未来日に予約されている弁当の更新を行う時にエラーにする', type: :feature do
  given!(:order) { create(:order, date: Time.zone.local(2017, 2, 4)) }
  given!(:lunchbox) { create(:lunchbox) }

  scenario '未来日に予約を入れた状態で、その弁当を更新する' do
    Timecop.freeze(Time.zone.local(2017, 2, 1)) do
      create(:order_item, lunchbox_id: lunchbox.id, order: order)

      visit edit_admin_lunchbox_path(lunchbox)

      fill_in 'Name', with: "new_lunchbox_name"

      click_button('Update Lunchbox')

      expect(page).to have_text('未来日に予約された弁当は更新できません')
      # expect(page).not_to have_text('new_lunchbox_name')
    end
  end
end
