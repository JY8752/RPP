# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  delete_date     :datetime
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
FactoryBot.define do
    factory :user do
        name { 'テストユーザー' }
        password { 'password' }
    end
end
