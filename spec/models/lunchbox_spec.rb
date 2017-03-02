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

require 'rails_helper'

RSpec.describe Lunchbox, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
