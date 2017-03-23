# == Schema Information
#
# Table name: orders
#
#  id         :integer          not null, primary key
#  date       :date             not null
#  closed_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Order < ApplicationRecord
  has_many :order_items
  SHOW_COUNT = 10



  def close(close_time = Time.current)
    update(closed_at: close_time)
  end

  def closed?
    closed_at?
  end
end
