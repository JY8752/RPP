# == Schema Information
#
# Table name: roles
#
#  id         :bigint           not null, primary key
#  enabled    :boolean          not null
#  level      :integer          not null
#  role       :integer          default("Java"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_roles_on_user_id  (user_id)
#
FactoryBot.define do
    factory :role do
        role { 0 }
        level { 1 }
        user_id { 1 }
        enabled { true }
    end
end
