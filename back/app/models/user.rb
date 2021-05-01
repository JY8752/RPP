# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  delete_date     :datetime
#  name            :string(255)      not null
#  password_digest :string(255)      not null
#  stage_level     :integer          not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
    has_secure_password
    has_many :roles

    validates :name, presence: true
end
