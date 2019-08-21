# == Schema Information
#
# Table name: order_items
#
#  id            :integer          not null, primary key
#  order_id      :integer          not null
#  lunchbox_id   :integer          not null
#  customer_name :string           not null
#  received_at   :datetime
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :order_item do
    customer_name { 'テスト' }
  end
end
