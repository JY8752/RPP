require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  #テストユーザー
  let(:user_a){ FactoryBot.create(:user, name: 'user_a', password: 'password', stage_level: 1) }
  before do
    #認証
    sign_in(user_a.id, user_a.password)
  end

  describe "GET /enemies/{ stage_id }" do
    it 'dukeクラスの情報が取得できること' do
      #enemyレコード作成
      duke = FactoryBot.create(:enemy, name: 'Duke', stage_level: 1)
      #API呼び出し
      get '/api/v1/enemies/1'
      #レスポンス変換
      parse_json
      #レスポンス確認
      expect(response.status).to eq 200
      expect(@json[:name]).to eq duke.name
      expect(@json[:stage_level]).to eq duke.stage_level
      expect(@json[:image_data]).not_to be nil

      expect(@json[:action_pattern].length).to eq 3
      first_turn_pattern = @json[:action_pattern][0]
      expect(first_turn_pattern[:turn_count]).to eq 1
      expect(first_turn_pattern[:attack_point]).to eq 5
      expect(first_turn_pattern[:message]).to eq 'dukeのこうげき'

      second_turn_pattern = @json[:action_pattern][1]
      expect(second_turn_pattern[:turn_count]).to eq 2
      expect(second_turn_pattern[:attack_point]).to eq 5
      expect(second_turn_pattern[:message]).to eq 'dukeのこうげき'
      
      third_turn_pattern = @json[:action_pattern][2]
      expect(third_turn_pattern[:turn_count]).to eq 3
      expect(third_turn_pattern[:attack_point]).to eq 10
      expect(third_turn_pattern[:message]).to eq 'dukeは変数のあたいをnullに変えた。<br>[Error] NullPointerException'

      expect(@json[:hp]).to eq Enemies::EnemiesConst::DUKE_HP
      expect(@json[:experience_point]).to eq Enemies::EnemiesConst::DUKE_EXPERIENCE_POINT
    end
  end
end
