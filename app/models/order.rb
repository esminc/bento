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
  MINIMUM_ORDER_ITEM_COUNT = 3

  has_many :order_items, dependent: :destroy

  scope :available, -> {
    where('date >= ?', Time.current) \
      .limit(SHOW_COUNT) \
      .order(date: :asc) \
      .reject(&:closed?)
  }

  def close!(close_time = Time.current)
    update!(closed_at: close_time)
  end

  def closed?
    closed_at?
  end

  def realized?
    closed? && item_count_satisfied?
  end

  def not_realized?
    closed? && item_count_shortage?
  end

  def aggregate_items(lunchboxes)
    reservation_number_table = aggregate_reservation_numbers(lunchboxes.map(&:id))
    reservation_price_table =  aggregate_reservation_prices(reservation_number_table, lunchboxes.map(&:price))
    [reservation_number_table << reservation_number_table.sum, reservation_price_table << reservation_price_table.sum]
  end

  def ordered_lunchboxes_and_count
    grouped_order_items = order_items.joins(:lunchbox).group('lunchboxes.id').order('lunchboxes.id').count
    grouped_order_items.map do |lunchbox_id, count|
      {lunchbox: Lunchbox.find(lunchbox_id), count: count}
    end
  end

  private

  def aggregate_reservation_numbers(lunchbox_ids)
    table = lunchbox_ids.each_with_object({}) {|lunchbox_id, num_table| num_table[lunchbox_id] = 0 }
    order_items.each {|item| table[item.lunchbox_id] += 1 }
    table.values
  end

  def aggregate_reservation_prices(numbers, prices)
    numbers.zip(prices).map do |num, price|
      num * price
    end
  end

  def item_count_satisfied?
    self.order_items.count >= MINIMUM_ORDER_ITEM_COUNT
  end

  def item_count_shortage?
    !item_count_satisfied?
  end
end
