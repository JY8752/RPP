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
class Role < ApplicationRecord
    belongs_to :user
    has_one :status

    enum role: { Java: 0, Ruby: 1, Rust: 2 }
end
