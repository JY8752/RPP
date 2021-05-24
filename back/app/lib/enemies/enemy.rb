#各enemyクラスの基底クラス
module Enemies
  class Enemy
    require "base64"
  
    attr_accessor :name
    attr_accessor :stage_level
    attr_accessor :binary
    attr_accessor :action_pattern
    attr_accessor :hp
    attr_accessor :experience_point
  
    def initialize(name:, stage_level:, binary:, action_pattern:, hp:, experience_point:)
      @name = name
      @stage_level = stage_level
      @binary = binary
      @action_pattern = action_pattern
      @hp = hp
      @experience_point = experience_point
    end
  
    def self.get_one_action_pattern(message, turn_count:, attack_point:)
      one_action_pattern = {
        turn_count: turn_count,
        attack_point: attack_point,
        message: message
      }
      one_action_pattern
    end
  
    def get_detail()
      base64 = Base64.strict_encode64(@binary)
      detail_hash = { 
        name: @name,
        stage_level: @stage_level,
        image_data: base64,
        action_pattern: @action_pattern,
        hp: @hp,
        experience_point: @experience_point
      }
      detail_hash
    end
  end
end