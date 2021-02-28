require 'rails_helper'

RSpec.describe "Users", type: :request do
    #ユーザー作成
    let(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }

    # ユーザー一覧取得
    describe 'GET /api/v1/users' do
        context 'ユーザーが3件のとき' do
            it 'ユーザーが3件取得できること' do
                # 認証を通す
                sign_in user_a.id, user_a.password
            end
        end
    end
    #ユーザー取得
    describe 'Get /api/v1/users/{ user_id }' do

    end
    # ユーザー作成
    describe 'POST /api/v1/users' do

    end
    # ユーザー更新
    describe 'PUT /api/v1/users/{ user_id ' do

    end
    # ユーザー削除
    describe 'DELETE /api/users/{ user_id' do

    end
end