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

FactoryGirl.define do
  factory :lunchbox do
    name 'sample弁当'
    price 400
  end

  factory :good_lunchbox, class: Lunchbox do
    id 2
    name "good"
    price 400
  end

end
