class OrdersController < ApplicationController
  def index
    # 注文日の一覧（トップページ）
    # TODO ここはほんとは all じゃなくて現時点から 2 週間後
    @orders = Order.all
  end

  def show
    # 予約確認画面
  end

  def confirm
    # 受取確認画面
  end
end
