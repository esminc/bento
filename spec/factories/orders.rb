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

FactoryGirl.define do
  factory :order do
    date Time.zone.local(2017, 2, 1)
  end
end
