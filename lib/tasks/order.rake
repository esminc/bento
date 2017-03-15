require_relative './rake_helpers'

namespace :order do
  desc '平日分の Order レコードを作成する'
  task create: :environment do
    today = Time.current.beginning_of_day
    orders_from_today = Order.where('date > ?', today)

    new_order_date = if orders_from_today.any?
                       next_weekday_of(orders_from_today.last.date)
                     else
                       next_weekday_of(today)
                     end

    order = Order.create!(date: new_order_date)
    puts "#{order.date} の Order レコードが正常に作成されました"
  end
end
