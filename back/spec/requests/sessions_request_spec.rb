require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    #ユーザー作成
    let(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }

    describe 'POST /api/v1/signin 認証' do
        context '正常なリクエストの場合' do
            it '認証が通ること' do
    
                #APIリクエスト
                sign_in user_a.id, user_a.password

                expect(response.status).to eq(200)
                expect(session[:user_id]).to eq user_a.id.to_s

                #レスポンスの確認
                expect(@json[:id]).to eq user_a.id
                expect(@json[:name]).to eq user_a.name
            end
        end

        context 'user_idが間違っている場合' do
            it 'エラーとなる' do
                # 採番されないuser_idを設定
                undefined_id = 0

                #APIリクエスト
                sign_in undefined_id, user_a.password

                expect(response.status).to eq(401)
                expect(session[:user_id]).to be(nil)

                #レスポンスの確認
                check_error_response(
                    Settings.api.error.E0001.code,
                    Settings.api.error.E0001.message,
                    "user_id: 0"
                )
            end
        end

        context 'パスワードが間違っている場合' do
            it 'エラーとなる' do
                # 誤ったパスワードを設定
                wrong_password = 'wrong_password'

                #APIリクエスト
                sign_in user_a.id, wrong_password

                expect(response.status).to eq(401)
                expect(session[:user_id]).to be(nil)

                #レスポンスの確認
                check_error_response(
                    Settings.api.error.E0002.code,
                    Settings.api.error.E0002.message,
                    { user_id: user_a.id.to_s, password: wrong_password }
                )
            end
        end
    end

    describe 'DELETE /api/v1/signout ログアウト' do
        context 'ログインしているとき' do
            it 'ログアウトできること' do
                #認証を通す
                sign_in user_a.id, user_a.password

                # APIリクエスト
                sign_out

                expect(response.status).to eq(204)
                expect(session[:user_id]).to be(nil)

            end
        end

        context 'ログインしていないとき' do
            it '認証されていないためエラーとなること' do
                #認証を通さずAPIリクエスト
                sign_out

                expect(response.status).to eq(401)
                expect(session[:user_id]).to be(nil)

                #レスポンスを確認する
                check_error_response(
                    Settings.api.error.E0003.code,
                    Settings.api.error.E0003.message,
                    nil
                )
            end
        end
    end
end
