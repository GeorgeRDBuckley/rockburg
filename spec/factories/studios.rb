# == Schema Information
#
# Table name: studios
#
#  id            :bigint(8)        not null, primary key
#  cost          :integer
#  description   :string
#  engineer_name :string
#  name          :string
#  weight        :integer          default(0)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

FactoryBot.define do
  factory :studio do
    name { "#{Faker::FunnyName.name} Studios" }
    engineer_name { Faker::FunnyName.name }
    cost { rand(1..10) * 100 }
  end
end
