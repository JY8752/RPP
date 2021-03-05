require 'rails_helper'

RSpec.describe "Users", type: :request do
    #ユーザー作成
    let!(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }

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
        context '有効なユーザーが2件のとき' do
            before do
                #2件目のユーザーを作成する
                FactoryBot.create(:user, name: 'user_b', password: 'password')
            end
            it 'ユーザーが1件新規で作成されること' do
                #APIリクエスト
                create_user name: 'user_c', password: 'password'

                #作成したレコード,レスポンスを確認する
                check_create_user_response
            end
        end

        context 'ユーザーが3件存在する場合' do
            before do
                #2件のユーザーを作成する
                2.times { FactoryBot.create(:user, name: 'user_b', password: 'password') }
            end
            it 'ユーザーの作成に失敗すること' do
                #APIリクエスト
                create_user name: 'user_c', password: 'password'

                # エラーレスポンスを確認する
                check_error_response(
                    Settings.api.error.E0006.code,
                    Settings.api.error.E0006.message,
                    status: 409
                )
            end
        end

        context '削除済みユーザーが1件有効ユーザーが2件の場合' do
            before do
                #2件目のユーザーを作成する
                FactoryBot.create(:user, name: 'user_b', password: 'password')
                #削除済みユーザーを1件作成する
                FactoryBot.create(:user, name: 'delete_user', password: 'password', delete_date: Time.zone.now)
            end
            it 'ユーザーが作成できること' do
                #APIリクエスト
                create_user name: 'user_c', password: 'password'

                #作成したレコード,レスポンスを確認する
                check_create_user_response
            end
        end

    end
    # ユーザー更新
    describe 'PUT /api/v1/users/{ user_id ' do

    end
    # ユーザー削除
    describe 'DELETE /api/users/{ user_id' do

    end
end