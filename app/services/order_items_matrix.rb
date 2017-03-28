class OrderItemsMatrix
  def initialize(order_date)
    @order_date = order_date
  end

  def generate
    matrix = []

    grouped_items = ActiveRecord::Base.connection.select_all(aggregate_sql).rows.map do |lunchbox_id, num|
      [lunchbox_id, num.to_i] # NOTE: 予約の入ってない弁当の数はnilになってるので0にする
    end.to_h
    lunchboxes = Lunchbox.where(id: grouped_items.keys).to_a

    header = [''] + lunchboxes.map(&:name) << '合計'
    numbers_row = ['個数'] + grouped_items.values << grouped_items.values.sum
    amounts = grouped_items.map do |lunchbox_id, num|
      lunchboxes.find {|lunchbox| lunchbox.id == lunchbox_id }.price * num
    end
    amounts_row = ['金額'] + amounts << amounts.sum

    matrix << header << numbers_row << amounts_row
  end

  private

  # NOTE: その日の予約数を弁当毎に集計するSQL
  def aggregate_sql
    sql = <<-SQL
    SELECT lunchboxes.id, lunchbox_count.cnt
    FROM lunchboxes LEFT JOIN
      (SELECT order_items.lunchbox_id, COUNT(order_items.lunchbox_id) AS cnt
      FROM order_items JOIN orders ON order_items.order_id = orders.id
      WHERE orders.date = ?
      GROUP BY order_items.lunchbox_id) AS lunchbox_count
    ON lunchboxes.id = lunchbox_count.lunchbox_id
    ORDER BY lunchboxes.id ASC
    SQL
    ActiveRecord::Base.send(:sanitize_sql_array, [sql, @order_date])
  end
end
