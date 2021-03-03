class UsersController < ApplicationController
  skip_before_action :check_is_signed_in, only: [:index, :create]

  # GET /users
  def index
    @users = User.all

    render json: @users
  end

  # GET /users/1
  def show
    render json: @user
  end

  # POST /users
  def create
    user = User.new(name: user_params[:name], password: user_params[:password])
    
    # ユーザーの作成に失敗したらエラーレスポンス
    if !user.save
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0004.code,
            Settings.api.error.E0004.message,
            user_params,
            400
        )
    end

    # ロールの作成に失敗したらエラーレスポンス
    role = user.roles.new(role: user_params[:role].to_i, level: 1, enabled: true)
    if !role.save
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0005.code,
            Settings.api.error.E0005.message,
            user_params,
            400
        )
    end

    response = User.joins(:roles).where(id: user.id).select('users.id, name, role, level').take
    render json: { user: response }, status: 201
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :role)
    end
end
