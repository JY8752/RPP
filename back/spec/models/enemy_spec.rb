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
require 'rails_helper'

RSpec.describe Enemy, type: :model do
  describe '#get_enemy' do
    it 'Dukeクラスの情報が取得できること' do
      duke = FactoryBot.create(:enemy, name: 'Duke', stage_level: 1)
      result = duke.get_enemy
      
      expect(result[:name]).to eq duke.name
      expect(result[:stage_level]).to eq duke.stage_level
      expect(result[:image_data]).not_to be nil

      expect(result[:action_pattern].length).to eq 3
      first_turn_pattern = result[:action_pattern][0]
      expect(first_turn_pattern[:turn_count]).to eq 1
      expect(first_turn_pattern[:attack_point]).to eq 5
      expect(first_turn_pattern[:message]).to eq 'dukeのこうげき'

      second_turn_pattern = result[:action_pattern][1]
      expect(second_turn_pattern[:turn_count]).to eq 2
      expect(second_turn_pattern[:attack_point]).to eq 5
      expect(second_turn_pattern[:message]).to eq 'dukeのこうげき'
      
      third_turn_pattern = result[:action_pattern][2]
      expect(third_turn_pattern[:turn_count]).to eq 3
      expect(third_turn_pattern[:attack_point]).to eq 10
      expect(third_turn_pattern[:message]).to eq 'dukeは変数のあたいをnullに変えた。\n[Error] NullPointerException'
    end
  end
end
