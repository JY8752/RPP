class SessionsController < ApplicationController
  skip_before_action :check_is_signed_in, only: [:sign_in]

  # 認証
  def sign_in
    begin
        user = User.find(session_params[:user_id]).authenticate(session_params[:password])
    rescue ActiveRecord::RecordNotFound => e
        return render json: { message: "wrong user_id", user_id: session_params[:user_id]}, status: 401
    end
    if user
        session[:user_id] = user.id
        render json: { message: "sign in success" }
    else 
        render json: { message: "sign in fail"}, status: 401
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
