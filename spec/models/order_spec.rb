require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#aggregate_items' do
    let!(:lunchbox1) { create(:lunchbox, name: '弁当1', price: 400) }
    let!(:lunchbox2) { create(:lunchbox, name: '弁当2', price: 300) }
    let!(:lunchbox3) { create(:lunchbox, name: '弁当3', price: 350) }
    let(:order) { create(:order) }

    before do
      create(:order_item, order: order, lunchbox_id: lunchbox1.id)
      create_list(:order_item, 3, order: order, lunchbox_id: lunchbox2.id)
      create(:order_item, order: order, lunchbox_id: lunchbox1.id)
    end

    it '注文された弁当の個数と値段が集計される' do
      expect(order.aggregate_items(Lunchbox.all)).to eq(
        [
          [2, 3, 0, 5],
          [2 * lunchbox1.price, 3 * lunchbox2.price, 0 * lunchbox3.price * 0, (2 * lunchbox1.price) + (3 * lunchbox2.price) + (lunchbox3.price * 0)]
        ]
      )
    end
  end
end
