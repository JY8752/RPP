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
class Enemy < ApplicationRecord
  #enemy.name = クラス名
  #enemyクラスのget_detailメソッド呼び出し
  def get_enemy()
    target_class = "Enemies::#{self.name}"
    Object.const_get(target_class).new(self.name, self.stage_level).get_detail
  end
end
