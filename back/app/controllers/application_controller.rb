class ApplicationController < ActionController::API
    before_action :check_is_signed_in

    #rescue_fromの評価は下から上らしい
    rescue_from Exception, with: :exception_handler
    rescue_from Exceptions::ApiCommonError, with: :api_common_error_handler

    private

    # API実行前に認証が通っていることを確認する
    def check_is_signed_in
        if !session[:user_id]
            # セッションにidが格納されていなければ401エラー
            render json: {
                code: Settings.api.error.E0003.code,
                message: Settings.api.error.E0003.message,
            }, status: 401
            return
        end

        @current_user = User.find(session[:user_id])
    end

    #ApiCommonErrorからjsonを作成する
    def api_common_error_handler(error)
        render json: {
            code: error.code,
            message: error.message,
            details: error.details
        }, status: error.status
    end

    # 共通エラー以外の全てのエラーを処理する
    def exception_handler(error)
        binding.pry
        render json: {
            code: Settings.api.error.E9999.code,
            message: Settings.api.error.E9999.message,
            details: error.class.to_s
        }, status: 500
    end
end
