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
    def update_user(id:, name: 'name', password: 'password', role: 0)
        put "/api/v1/users/#{ id }", params: get_user_params(name, password, role)
    end

    #レベルアップ
    def levelup(id)
        put "/api/v1/users/levelup/#{ id }"
    end

    #ステータス取得
    def get_user_status(id)
      get "/api/v1/users/status/#{ id }"
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

        #レスポンスの確認
        expect(response.status).to eq 201
        expect(@json[:user][:id]).to eq user.id
        expect(@json[:user][:name]).to eq user.name
        expect(@json[:user][:role]).to eq Role.roles[role.role.to_sym]
        expect(@json[:user][:level]).to eq role.level

        expect(user.delete_date).to be nil
        expect(role.enabled).to be true

        #ステージレベル
        expect(user.stage_level).to eq 1
        expect(@json[:user][:stage_level]).to eq 1

        #作成したロールのステータス確認
        expect(3).to eq user.roles.size
        user.roles.each do |role|
          status = role.status
          #デフォルト値取得
          default_value = role.get_default_settings

          expect(default_value.hp).to eq status.hp
          expect(default_value.mp).to eq status.mp
          expect(default_value.attack).to eq status.attack
          expect(default_value.defence).to eq status.defence
          expect(default_value.next_level_point).to eq status.next_level_point
        end
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
        expect(json_user[:stage_level]).to eq user.stage_level

        expect(user.delete_date).to be nil
        expect(role.enabled).to be true

    end

    #ユーザー更新できたことを確認する
    def check_update_user(name:, password:, role:)
        parse_json

        # ユーザーをDBから取得
        user = User.find_by(id: @json[:id])
        user_role = user.roles.where(enabled: true).take

        #ステータスの確認
        expect(response.status).to eq 200

        #レスポンスの確認
        expect(@json[:id]).to eq user.id
        expect(@json[:name]).to eq name
        expect(@json[:role]).to eq role
        expect(@json[:level]).to eq user_role.level
        expect(@json[:stage_level]).to eq user.stage_level

        #レコードの確認
        user.roles.map do |role|
            if role == user_role
                expect(user.name).to eq name
                expect(user.authenticate(password)).not_to be false
                expect(user.delete_date).to be nil
                expect(Role.roles[user_role.role.to_sym]).to eq role.role_before_type_cast
                expect(user_role.enabled).to be true
            else
                expect(role.enabled).to be false
            end
        end
    end

    #ユーザー作成レスポンスを確認する
    def check_get_status()
        #jsonレスポンスをパースする
        parse_json
        # 作成したユーザーをDBから取得
        user = User.find_by(id: @json[:id])
        role = user.roles.where(enabled: true).first
        status = role.status

        expect(response.status).to eq 200
        expect(@json[:id]).to eq user.id
        expect(@json[:role]).to eq role.role_before_type_cast
        expect(@json[:level]).to eq role.level
        expect(@json[:hp]).to eq status.hp
        expect(@json[:mp]).to eq status.mp
        expect(@json[:attack]).to eq status.attack
        expect(@json[:defence]).to eq status.defence
        expect(@json[:next_level_point]).to eq status.next_level_point
    end

    def check_updated_status(user_id:, before_status:)
      #ロール
      role = User.find_by(id: user_id)
        .roles.where(enabled: true).first
      #レベルアップ後のステータス
      after_status = role.status
      #設定値
      update_settings = role.get_update_settings

      expect(before_status.hp + update_settings.hp).to eq after_status.hp
      expect(before_status.mp + update_settings.mp).to eq after_status.mp
      expect(before_status.attack + update_settings.attack).to eq after_status.attack
      expect(before_status.defence + update_settings.defence).to eq after_status.defence
      expect(update_settings.next_level_point_base_value * role.level).to eq after_status.next_level_point
    end

    private

    def get_user_params(name, password, role)
        user_params = {
            user: {
                name: name,
                password: password,
                role: role
            }
        }
    end
end