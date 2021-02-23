require 'rails_helper'

RSpec.describe "Sessions", type: :request do
    describe '認証' do
        let(:success_user) { FactoryBot.create(:user, name: 'success_user', password: 'password') }

        context '登録済みのユーザーの場合' do

            it '認証が通ること' do
                post_params = {
                    user_id: success_user.id,
                    password: success_user.password 
                }

                post '/api/v1/signin', params: { session: post_params }
                json = JSON.parse(response.body)

                p json['message']
                p post_params  

                expect(response.status).to eq(200)
            end
        end
    end
end
