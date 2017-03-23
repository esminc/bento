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

  class << self
    # NOTE 操作しているその日から14日後までのうちの出社日（祝祭日・土日以外）を返す。
    #      年末年始休暇などは毎年違うので、時期が近くなったら適宜対応すること。
    def on_weekday
      start_date = Time.current
      end_date = Time.current.since(14.days)
      orders = Order.where(date: start_date..end_date)

      orders.reject {|o| HolidayJp.holiday?(o.date) || o.date.wday == 6 || o.date.wday == 0 }
    end
  end

  def close(close_time)
    update(closed_at: close_time)
  end
end
