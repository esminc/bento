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

FactoryBot.define do
  factory :order do
    date { Time.zone.local(2017, 2, 1) }

    trait :closed do
      closed_at { Time.zone.local(2017, 2, 1, 9, 20) }
    end
  end
end
