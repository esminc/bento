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

class OrderItem < ApplicationRecord
  # XXX データモデルの関係としておかしい（本当は order item has one lunchbox だと思う）けど、
  #     やりたいことを実現するには belongs_to lunchbox にするしかない。
  belongs_to :lunchbox
  belongs_to :order

  validates :customer_name, presence: true
end
