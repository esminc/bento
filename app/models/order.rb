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
  SHOW_COUNT = 10

  has_many :order_items

  scope :available, -> {
    where('date >= ?', Time.current) \
      .limit(SHOW_COUNT) \
      .order(date: :asc) \
      .reject(&:closed?)
  }

  def close(close_time = Time.current)
    update(closed_at: close_time)
  end

  def closed?
    closed_at?
  end
end
