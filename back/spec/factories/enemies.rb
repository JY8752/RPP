# == Schema Information
#
# Table name: enemies
#
#  id          :bigint           not null, primary key
#  name        :string(255)      not null
#  stage_level :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :enemy do
    name { "MyString" }
    stage_level { 1 }
  end
end
