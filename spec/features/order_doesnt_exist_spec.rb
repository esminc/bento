require 'rails_helper'

RSpec.feature '予約できる日が存在しない時', type: :feature do
  scenario '予約者は注文日付選択画面が見れる' do
    visit orders_path

    expect(page).to have_text('お弁当を予約する')
    expect(page).to have_text('予約できる日がありません')
  end
end
