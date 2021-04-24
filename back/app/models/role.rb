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

    #レベルアップ時のベースポイントを返す
    def get_update_settings
      if self.Java?
        Settings.api.status.Java.update
      elsif self.Ruby?
        Settings.api.status.Ruby.update
      else
        Settings.api.status.Rust.update
      end
    end

    #デフォルトのステータスを返す
    def get_default_settings
      if self.Java?
        Settings.api.status.Java.default
      elsif self.Ruby?
        Settings.api.status.Ruby.default
      else
        Settings.api.status.Rust.default
      end
    end
end
