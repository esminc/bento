class OrdersController < ApplicationController
  def index
    # 注文日の一覧（トップページ）
    # TODO ここはほんとは all じゃなくて現時点から 2 週間後
    @orders = Order.all
  end
end
