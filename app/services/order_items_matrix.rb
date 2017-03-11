class OrderItemsMatrix
  def initialize(order_date)
    @order_date = order_date
  end

  def generate
    matrix = []

    grouped_items = ActiveRecord::Base.connection.select_all(aggregate_sql).rows.map do |lunchbox_id, num|
      [lunchbox_id, num.to_i] # NOTE: nilの値を0にするため
    end.to_h
    lunchboxes = Lunchbox.where(id: grouped_items.keys).to_a

    header = [''] + lunchboxes.map(&:name) << '合計'
    numbers_row = ['個数'] + grouped_items.values << grouped_items.values.sum
    amounts = grouped_items.map do |lunchbox_id, num|
      lunchboxes[lunchbox_id - 1].price * num
    end
    amounts_row = ['金額'] + amounts << amounts.sum

    matrix << header << numbers_row << amounts_row
  end

  private

  def aggregate_sql
    sql = <<-SQL
    select lunchboxes.id, lunchbox_count.cnt
    from lunchboxes left join
      (select order_items.lunchbox_id, count(order_items.lunchbox_id) as cnt
      from order_items join orders on order_items.order_id = orders.id
      where orders.date = ?
      group by order_items.lunchbox_id) as lunchbox_count
    on lunchboxes.id = lunchbox_count.lunchbox_id
    order by lunchboxes.id asc
    SQL
    ActiveRecord::Base.send(:sanitize_sql_array, [sql, @order_date])
  end
end
