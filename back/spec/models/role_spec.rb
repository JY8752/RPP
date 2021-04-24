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
require 'rails_helper'

RSpec.describe Role, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
