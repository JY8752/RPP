#ステージ1 duke
module Enemies 
  require 'forwardable'
  class Duke
    extend Forwardable
  
    def_delegators :@enemy, :get_detail

    def initialize(name, stage_level)
      #画像データ
      binary = File.read(Rails.root.join('app', 'assets', 'images', 'duke.png'))
      #行動パターン
      action_pattern = [
        Enemy.get_one_action_pattern('dukeのこうげき', turn_count: 1, attack_point: 5),
        Enemy.get_one_action_pattern('dukeのこうげき', turn_count: 2, attack_point: 5),
        Enemy.get_one_action_pattern('dukeは変数のあたいをnullに変えた。<br>[Error] NullPointerException', turn_count: 3, attack_point: 10)
      ]
      @enemy ||= Enemies::Enemy.new(
        name: name,
        stage_level: stage_level,
        binary: binary,
        action_pattern: action_pattern,
        hp: Enemies::EnemiesConst::DUKE_HP,
        experience_point: Enemies::EnemiesConst::DUKE_EXPERIENCE_POINT
      )
    end
  end
end
