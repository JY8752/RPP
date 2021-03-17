#specを書くための共通処理
#rails_helper.rbにincludeして使う
module SpecUtils
    ###################################################
    # APIリクエスト
    ###################################################

    #認証を通す
    def sign_in(user_id, password)
        post_params = {
            session: {
                user_id: user_id,
                password: password 
            }
        }
        #APIリクエスト
        post '/api/v1/signin', params: post_params
        #レスポンスをパース
        parse_json
    end

    #ログアウトする
    def sign_out
        delete '/api/v1/signout'
        #エラーレスポンスがあるときもあるためパース処理しておく
        parse_json
    end

    #ユーザー作成
    def create_user(name:, password:, role: 0)
        user_params = {
            user: {
                name: name,
                password: password,
                role: role
            }
        }
        post '/api/v1/users', params: user_params
        parse_json
    end

    #ユーザー削除
    def delete_user(id) 
        delete "/api/v1/users/#{ id }"
    end

    #ユーザー一覧
    def get_users()
        get '/api/v1/users'
    end

    #ユーザー取得
    def get_user(id)
        get "/api/v1/users/#{ id }"
    end

    #ユーザー更新
    def update_user(id:, name:, password:, role:, level:)
        put "/api/v1/users/#{ id }", params: get_user_params(name, password, role, level)
    end

    ###################################################
    # spec内の共通処理
    ###################################################

    #エラーレスポンスを確認する
    def check_error_response(code, message, details: nil, status: 400)
        expect(response.status).to eq status
        parse_json
        expect(@json[:code]).to eq(code)
        expect(@json[:message]).to eq(message)
        expect(@json[:details]).to eq(details) if details
    end

    #レスポンスのbodyをパースする
    def parse_json
        #ボディーパラメーターが空なら空のハッシュを返す
        @json = response.body.blank? ? {} : JSON.parse(response.body, symbolize_names: true)
    end

    #ユーザー作成レスポンスを確認する
    def check_create_user()
        #jsonレスポンスをパースする
        parse_json
        # 作成したユーザーをDBから取得
        user = User.find(@json[:user][:id])
        role = user.roles.where(user_id: user.id).first

        expect(response.status).to eq 201
        expect(@json[:user][:id]).to eq user.id
        expect(@json[:user][:name]).to eq user.name
        expect(@json[:user][:role]).to eq Role.roles[role.role.to_sym]
        expect(@json[:user][:level]).to eq role.level

        expect(user.delete_date).to be nil
        expect(role.enabled).to be true
    end

    #ユーザー削除できたことを確認する
    def check_delete_user(id)
        expect(response.status).to eq 204

        user = User.find_by(id: id)
        expect(user).not_to be nil

        expect(user.delete_date).not_to be nil
    end

    #ユーザー取得できたことを確認する
    def check_get_user(index: 0)
        #一覧の場合、指定のインデックスのユーザー情報
        parse_json
        json_user = @json.instance_of?(Array) ? @json[index] : @json

        expect(response.status).to eq 200

        # ユーザーをDBから取得
        user = User.find(json_user[:id])
        role = user.roles.where(user_id: user.id).first

        expect(json_user[:id]).to eq user.id
        expect(json_user[:name]).to eq user.name
        expect(json_user[:role]).to eq Role.roles[role.role.to_sym]
        expect(json_user[:level]).to eq role.level

        expect(user.delete_date).to be nil
        expect(role.enabled).to be true

    end

    #ユーザー更新できたことを確認する
    def check_update_user(name:, password:, role:, level:)
        parse_json

        # ユーザーをDBから取得
        user = User.find_by(id: @json[:id])
        user_role = user.roles.where(user_id: user.id).first

        #ステータスの確認
        expect(response.status).to eq 200

        #レスポンスの確認
        expect(@json[:id]).to eq user.id
        expect(@json[:name]).to eq name
        expect(@json[:role]).to eq role
        expect(@json[:level]).to eq level

        #レコードの確認
        expect(user.name).to eq name
        expect(user.authenticate(password)).not_to be false
        expect(user.delete_date).to be nil
        expect(Role.roles[user_role.role.to_sym]).to eq role
        expect(user_role.level).to eq level
        expect(user_role.enabled).to be true
    end

    private

    def get_user_params(name, password, role, level)
        user_params = {
            user: {
                name: name,
                password: password,
                role: role,
                level: level
            }
        }
    end
end