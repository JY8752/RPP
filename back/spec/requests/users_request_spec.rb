require 'rails_helper'

RSpec.describe "Users", type: :request do
    #ユーザー作成
    !let(:user_a) { FactoryBot.create(:user, name: 'user_a', password: 'password') }

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
                create_user 'user_a', 'password', 0

                #レスポンスを取得する
                parse_json

                # 作成したユーザーをDBから取得
                user = User.find(@json[:user][:id].to_i)
                role = user.roles.where(role: 0).first

                expect(response.status).to eq 201
                expect(@json[:user][:id]).to eq user.id
                expect(@json[:user][:name]).to eq user.name
                expect(@json[:user][:role]).to eq Role.roles[role.role.to_sym]
                expect(@json[:user][:level]).to eq role.level

                expect(user.delete_date).to be nil
                expect(role.enabled).to be true
            end
        end

        context 'ユーザーが3件存在する場合' do
            before do
                #2件目のユーザーを作成する
                FactoryBot.create(:user, name: 'user_b', password: 'password')
            end
            it 'ユーザーの作成に失敗すること' do

            end
        end

        context '削除済みユーザーが1件有効ユーザーが2件の場合' do
            before do
                #2件目のユーザーを作成する
                FactoryBot.create(:user, name: 'user_b', password: 'password')
            end
            it 'ユーザーが作成できること' do

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