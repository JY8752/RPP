require 'rails_helper'

RSpec.describe "Users", type: :request do
    #ユーザー作成
    let!(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password', stage_level: 1) }
    let!(:role_java) { FactoryBot.create(:role, user_id: user_a.id, role: 0) }
    let!(:role_ruby) { FactoryBot.create(:role, user_id: user_a.id, role: 1, enabled: false) }
    let!(:role_rust) { FactoryBot.create(:role, user_id: user_a.id, role: 2, enabled: false) }
    let!(:user_a_status) { FactoryBot.create(:status, role_id: role_java.id) }

    # ユーザー一覧取得
    describe 'GET /api/v1/users' do
        context 'ユーザーが3件のとき' do
            before do
                #ユーザーを2件作成する
                2.times do
                    user = FactoryBot.create(:user, name: 'user_b', password: 'password', stage_level: 1)
                    FactoryBot.create(:role, user_id: user.id)
                end
            end
            it 'ユーザーが3件取得できること' do
                #APIリクエスト
                get_users
                #リクエストjsonをパースする
                parse_json
                #ユーザーが3件取得できたことを確認する
                expect(@json.size).to eq 3

                check_get_user(index: 0)
                check_get_user(index: 1)
                check_get_user(index: 2)
            end
        end

        context 'ユーザーが0件のとき' do
            before { User.destroy_all }
            it 'エラーとならないこと' do
                #APIリクエスト
                get_users
                #レスポンスjson をパースする
                parse_json

                expect(@json.empty?).to be true
            end
        end
    end

    #ユーザー取得
    describe 'Get /api/v1/users/{ user_id }' do
        #認証
        before { sign_in(user_a.id, 'password') }

        context 'ユーザーが1件以上あるとき' do
            it 'ユーザーが1件取得できること' do
                #APIリクエスト
                get_user(user_a.id)
                check_get_user
            end
            
            it '削除済みのユーザーを取得できないこと' do
                #ユーザーaを削除
                delete_user(user_a.id)
                #APIリクエスト
                get_user(user_a.id)
                check_error_response(
                    Settings.api.error.E0007.code,
                    Settings.api.error.E0007.message,
                    details: user_a.id
                )
            end
        end

        context '存在しないユーザーidを指定した時' do
            it '404エラーとなること' do
                #APIリクエスト(採番されないid)
                get_user(0)
                check_error_response(
                    Settings.api.error.E0001.code,
                    Settings.api.error.E0001.message,
                    details: 0,
                    status: 404
                )
            end
        end
    end

    # ユーザー作成
    describe 'POST /api/v1/users' do
        context '有効なユーザーが2件のとき' do
            before do
                #2件目のユーザーを作成する
                FactoryBot.create(:user, name: 'user_b', password: 'password', stage_level: 1)
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
                2.times { FactoryBot.create(:user, name: 'user_b', password: 'password', stage_level: 1) }
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
                FactoryBot.create(:user, name: 'user_b', password: 'password', stage_level: 1)
                #削除済みユーザーを1件作成する
                FactoryBot.create(:user, name: 'delete_user', password: 'password', delete_date: Time.zone.now, stage_level: 1)
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

        #エラー検証
        it 'エラーが出ないこと' do
          params = {"user":{"id":nil,"name":"yamanaka","role":"Java","level":nil,"password":"password","isInputForm":false,"isRoleButtons":false,"isConfirmLanguage":false,"isUserData":true,"isConfirmUserData":true,"isCreated":false,"isPasswordForm":false}}
          #APIリクエスト
          post '/api/v1/users', params: params
        end
    end

    # ユーザー更新
    describe 'PUT /api/v1/users/{ user_id } ' do
        #認証を通す
        before { sign_in(user_a.id, 'password') }
        context 'ユーザーが1件以上存在するとき' do
            it 'ユーザーを1件更新できること' do
                #APIリクエスト
                update_user(id: user_a.id, name: 'update_user', password: 'update', role: Role.roles[:Ruby])
                #結果を確認
                check_update_user(name: 'update_user', password: 'update', role: Role.roles[:Ruby])
            end
        end
        context 'ユーザーが存在しないとき' do
            it 'E0001エラーとなること' do
                #採番されないid
                undefined_id = 0
                #API実施
                update_user(id: undefined_id)
                #エラーレスポンスを確認する
                check_error_response(
                    Settings.api.error.E0001.code,
                    Settings.api.error.E0001.message,
                    status: 404
                )
            end
        end
        context 'ユーザーが削除済みのとき' do
            it 'E0007エラーとなること' do
                #ユーザーaを削除
                delete_user(user_a.id)
                #APIリクエスト
                update_user(id: user_a.id)
                check_error_response(
                    Settings.api.error.E0007.code,
                    Settings.api.error.E0007.message,
                    details: user_a.id
                )
            end
        end
    end

    # ユーザー削除
    describe 'DELETE /api/v1/users/{ user_id }' do
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

    #レベルアップ
    describe 'PUT /api/v1/users/levelup/{ user_id }' do
        #認証を通す
        before { sign_in(user_a.id, 'password') }
        context 'レベル1の存在しているユーザーを指定したとき' do
            it 'レベルが２となっていること' do
                #API実施
                levelup(user_a.id)
                #レスポンスを確認する
                check_get_user
            end
            it 'ステータスが更新されていること' do
              #レベルアップ前のステータス
              status = user_a.roles.where(enabled: true).first.status
              #API実施
              levelup(user_a.id)
              #ステータスを確認する
              check_updated_status user_id: user_a.id, before_status: status
            end
        end
        context '存在しないユーザーを指定したとき' do
            it 'E0001エラーとなる' do
                #採番されないid
                undefined_id = 0
                #API実施
                levelup(undefined_id)
                #エラーレスポンスを確認する
                check_error_response(
                    Settings.api.error.E0001.code,
                    Settings.api.error.E0001.message,
                    status: 404
                )
            end 
        end
        context '削除済みのユーザーを指定したとき' do
            it 'E0007エラーとなること' do
                #ユーザーaを削除
                delete_user(user_a.id)
                #APIリクエスト
                levelup(user_a.id)
                check_error_response(
                    Settings.api.error.E0007.code,
                    Settings.api.error.E0007.message,
                    details: user_a.id
                )
            end
        end
    end

    #ステータス
    describe 'GET /api/v1/users/status/{ user_id }' do
      #認証を通す
      before { sign_in(user_a.id, 'password') }
      context '存在しているユーザーを指定した時' do
        it 'ステータスが取得できること' do
          # ステータス取得
          get_user_status(user_a.id)
          # レスポンスを確認
          check_get_status
        end
      end
      context '存在していないユーザーを指定した時' do
        it 'E0001エラーとなること' do
          #採番されないid
          undefined_id = 0
          #ステータス取得
          get_user_status(undefined_id)
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