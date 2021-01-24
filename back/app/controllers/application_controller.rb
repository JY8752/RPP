class ApplicationController < ActionController::API
    before_action :check_is_signed_in

    def check_is_signed_in
        if !session[:user_id]
            # セッションにidが格納されていなければ401エラー
            render json: { message: "unauthorized" }, status: 401
            return
        end

        @user = User.find(session[:user_id])
    end
end
