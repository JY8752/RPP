class SessionsController < ApplicationController
  skip_before_action :check_is_signed_in, only: [:sign_in]

  # 認証
  def sign_in
    user_id = session_params[:user_id]
    password = session_params[:password]

    begin
        user = User.find(user_id).authenticate(password)
    rescue => e
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0001.code,
            Settings.api.error.E0001.message,
            "user_id: #{user_id}",
            401
        )
        return
    end

    if user
        session[:user_id] = user_id
        render json: user
    else
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0002.code,
            Settings.api.error.E0002.message,
            { user_id: user_id, password: password },
            401
        )
    end
  end

  def sign_out
    session.delete(:user_id)
  end

  private

  def session_params
    params.require(:session).permit(:user_id, :password)
  end
end
