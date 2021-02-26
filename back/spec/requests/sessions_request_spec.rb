require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    #ユーザー作成
    let(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }
    # bodyパラメーター
    let(:post_params) {
        {
            session: {
                user_id: user_a.id,
                password: user_a.password 
            }
        }
    }

    describe 'POST /api/v1/signin 認証' do
        context '正常なリクエストの場合' do
            it '認証が通ること' do
    
                #APIリクエスト
                post '/api/v1/signin', params: post_params 
                #レスポンス
                json = JSON.parse(response.body)

                expect(response.status).to eq(200)
                expect(json['message']).to eq('sign in success')
                expect(response.header['Set-Cookie']).not_to be(nil)
            end
        end

        context 'user_idが間違っている場合' do
            it 'エラーとなる' do
                # 採番されないuser_idを設定
                post_params[:session][:user_id] = 0

                #APIリクエスト
                post '/api/v1/signin', params: post_params
                #レスポンス
                json = JSON.parse(response.body)

                expect(response.status).to eq(401)
                expect(json['message']).to eq('wrong user_id')
                expect(response.header['Set-Cookie']).to be(nil)
            end
        end

        context 'パスワードが間違っている場合' do
            it 'エラーとなる' do
                # 誤ったパスワードを設定
                post_params[:session][:password] = 'wrong_password'

                #APIリクエスト
                post '/api/v1/signin', params: post_params
                #レスポンス
                json = JSON.parse(response.body)

                expect(response.status).to eq(401)
                expect(json['message']).to eq('sign in fail')
                expect(response.header['Set-Cookie']).to be(nil)
            end
        end
    end

    describe 'DELETE /api/v1/signout ログアウト' do
        context 'ログインしているとき' do
            it 'ログアウトできること' do
                #認証を通す
                post '/api/v1/signin', params: post_params

                # APIリクエスト
                delete '/api/v1/signout' 

                expect(response.status).to eq(204)
                expect(session[:user_id]).to be(nil)

            end
        end

        context 'ログインしていないとき' do
            it '' do
                #認証を通さずAPIリクエスト
                delete '/api/v1/signout'
            end
        end
    end
end
