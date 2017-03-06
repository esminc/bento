class OrdersController < ApplicationController
  def index
    # TODO ここはほんとは all じゃなくて現時点から 2 週間後
    @orders = Order.all
  end
end
