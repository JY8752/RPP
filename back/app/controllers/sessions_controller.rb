class SessionsController < ApplicationController
  skip_before_action :check_is_signed_in, only: [:sign_in]

  # 認証
  def sign_in
    user = User.find_by(name: session_params[:name]).authenticate(params[:password])
    session[:user_id] = user.id
    render json: { message: "sign in success" }
  end

  def sign_out
    session[:user_id] = nil
  end

  private

  def session_params
    params.require(:session).permit(:name, :password)
  end
end
