require 'rails_helper'

RSpec.describe OrderItemsMatrix do
  describe '#generate' do
    let(:lunchbox1) { create(:lunchbox, name: '弁当1', price: 400) }
    let(:lunchbox2) { create(:lunchbox, name: '弁当2', price: 300) }
    let(:order) { create(:order) }

    before do
      create(:order_item, order: order, lunchbox_id: lunchbox1.id)
      create_list(:order_item, 3, order: order, lunchbox_id: lunchbox2.id)
      create(:order_item, order: order, lunchbox_id: lunchbox1.id)
    end

    it '弁当の個数が集計される' do
      expect(OrderItemsMatrix.new(order.date).generate).to eq(
        [
          ['', lunchbox1.name, lunchbox2.name, '合計'],
          ['個数', 2, 3, 5],
          ['金額', 2 * lunchbox1.price, 3 * lunchbox2.price, 2 * lunchbox1.price + 3 * lunchbox2.price]
        ]
      )
    end
  end
end
