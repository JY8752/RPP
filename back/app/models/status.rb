# == Schema Information
#
# Table name: statuses
#
#  id               :bigint           not null, primary key
#  attack           :integer          not null
#  defence          :integer          not null
#  hp               :integer          not null
#  mp               :integer          not null
#  next_level_point :integer          not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  role_id          :bigint           not null
#
# Indexes
#
#  index_statuses_on_role_id  (role_id)
#
# Foreign Keys
#
#  fk_rails_...  (role_id => roles.id)
#
class Status < ApplicationRecord
  belongs_to :role
end
