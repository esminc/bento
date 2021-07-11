# == Schema Information
#
# Table name: lunchboxes
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  price      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Lunchbox < ApplicationRecord
  has_many :order_items
  has_many :orders, through: :order_items

  # validation

  validate :prevent_future_reserved_lunchbox, on: :update

  private
    def prevent_future_reserved_lunchbox
      # 弁当に紐づくオーダーを取ってくる
      # 未来日のオーダーに自分が含まれているかを確認
      # 含まれている場合は更新させない
      # puts orders.where("date > ?", Date.current).present?
      # puts orders.first.date
      # puts self.name
      # puts Date.current
      # puts"###################"

      if orders.where("date > ?", Date.current).present?
        errors.add(:future_date, "未来日に予約された弁当は更新できません")
      end
    end

end
