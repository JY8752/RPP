require 'rails_helper'

RSpec.describe "Users", type: :request do
    #ユーザー作成
    let!(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }
    let!(:role_a) { FactoryBot.create(:role, user_id: user_a.id) }

    # ユーザー一覧取得
    describe 'GET /api/v1/users' do
        context 'ユーザーが3件のとき' do
            before do
                #ユーザーを2件作成する
                2.times do
                    user = FactoryBot.create(:user, name: 'user_b', password: 'password')
                    FactoryBot.create(:role, user_id: user.id)
                end
            end
            it 'ユーザーが3件取得できること' do
                #APIリクエスト
                get_users
                #リクエストjsonをパースする
                parse_json
                #ユーザーが3件取得できたことを確認する
                expect(response.status).to eq 200
                expect(@json.size).to eq 3

                check_get_user(index: 0)
                check_get_user(index: 1)
                check_get_user(index: 2)
            end
        end

        context 'ユーザーが0件のとき' do
            it 'エラーとならないこと' do

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

                #jsonレスポンスをパースする
                parse_json

                #作成したレコード,レスポンスを確認する
                check_create_user
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

                #jsonレスポンスをパースする
                parse_json

                #作成したレコード,レスポンスを確認する
                check_create_user
            end
        end

    end

    # ユーザー更新
    describe 'PUT /api/v1/users/{ user_id ' do

    end

    # ユーザー削除
    describe 'DELETE /api/users/{ user_id }' do
        before do
            #認証を通す
            sign_in(user_a.id, 'password')
        end

        context 'ユーザーが存在していれば' do
            it 'ユーザーが削除できること' do
                #API実施
                delete_user(user_a.id)
                #削除できたことを確認する
                check_delete_user(user_a.id)
            end
        end

        context 'ユーザーが存在していなければ' do
            it 'エラーとなる' do
                #採番されないid
                undefined_id = 0
                #API実施
                delete_user(undefined_id)
                #エラーレスポンスを確認する
                check_error_response(
                    Settings.api.error.E0001.code,
                    Settings.api.error.E0001.message,
                    status: 404
                )
            end
        end
    end
end