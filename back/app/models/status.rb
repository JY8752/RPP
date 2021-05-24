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

  #レベルアップ時のステータス更新
  def updae_status(next_level, update_base_point)
    hp = self.hp + update_base_point.hp
    mp = self.mp + update_base_point.mp
    attack = self.attack + update_base_point.attack
    defence = self.defence + update_base_point.defence
    next_level_point = next_level * update_base_point.next_level_point_base_value

    self.update(
      hp: hp,
      mp: mp,
      attack: attack,
      defence: defence,
      next_level_point: next_level_point
    )
  end
end
