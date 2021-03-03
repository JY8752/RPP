#specを書くための共通処理
#rails_helper.rbにincludeして使う
module SpecUtils
    ###################################################
    # APIリクエスト
    ###################################################

    #認証を通す
    def sign_in user_id, password
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
    def create_user(name, password, role)
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

    ###################################################
    # spec内の共通処理
    ###################################################

    #エラーレスポンスを確認する
    def check_error_response(code, message, details) 
        expect(@json[:code]).to eq(code)
        expect(@json[:message]).to eq(message)
        expect(@json[:details]).to eq(details) if details
    end

    #レスポンスのbodyをパースする
    def parse_json
        #ボディーパラメーターが空なら空のハッシュを返す
        @json = response.body.blank? ? {} : JSON.parse(response.body, symbolize_names: true)
    end
end