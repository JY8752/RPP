class UsersController < ApplicationController
    before_action :set_user, only: [:show, :update, :destroy, :levelup]
    skip_before_action :check_is_signed_in, only: [:index, :create]

  # GET /users
  def index
    #有効ユーザー一覧を取得
    users = User.joins(:roles).select('users.id, name, role, level')
        .where(delete_date: nil)
        .where('roles.enabled = true')
    render json: users
  end

  # GET /users/1
  def show
    render json: create_user_response(params[:id])
  end

  # POST /users
  def create
    # 有効なユーザーが既に3件存在する場合エラーレスポンス
    enabled_users = User.where(delete_date: nil)
    if enabled_users.size > 2
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0006.code,
            Settings.api.error.E0006.message,
            status: 409
        )
    end

    user = User.new(name: user_params[:name], password: user_params[:password])
    
    # ユーザーの作成に失敗したらエラーレスポンス
    if !user.save
        raise Exceptions::ApiCommonError.new(
            Settings.api.error.E0004.code,
            Settings.api.error.E0004.message,
            details: user_params,
            status: 400
        )
    end

    #ユーザー作成時にロールは全て作成しておく
    Role.roles.map do |key, value|
        if value == user_params[:role].to_i
            #指定があったロールは有効に
            role = user.roles.new(role: value, level: 1, enabled: true)
        else
            role = user.roles.new(role: value, level: 1, enabled: false)
        end
        
        # ロールの作成に失敗したらエラーレスポンス
        if !role.save
            raise Exceptions::ApiCommonError.new(
                Settings.api.error.E0005.code,
                Settings.api.error.E0005.message,
                details: user_params
            )
        end
    end

    render json: { user: create_user_response(user.id) }, status: 201
  end

  # PATCH/PUT /users/1
  def update
    @user.update(update_user_params)

    #ロールに変更があった場合
    if update_role_params[:role] && @user.roles.where(enabled: true).take.role_before_type_cast != update_role_params[:role].to_i
        @user.roles.map do |role|
            if role.role_before_type_cast == update_role_params[:role].to_i
                role.update(enabled: true)
            else
                role.update(enabled: false)
            end
        end
    end

    render json: create_user_response(@user.id)
  end

  # DELETE /users/1
  def destroy
    @user.update(delete_date: Time.zone.now)
    head 204
  end

  # PUT /users/levelup/1
  def levelup
    role = @user.roles.where(enabled: true).take
    role.update(level: role.level + 1)
    render json: create_user_response(@user.id)
  end

  private

    #ユーザーの存在を確認しセットする
    def set_user
        @user = User.find_by(id: params[:id])
        #ユーザーが見つからない
        if !@user
            raise Exceptions::ApiCommonError.new(
                Settings.api.error.E0001.code,
                Settings.api.error.E0001.message,
                details: params[:id].to_i,
                status: 404
            )
        end
        #ユーザーが削除済み
        if @user.delete_date
            raise Exceptions::ApiCommonError.new(
                Settings.api.error.E0007.code,
                Settings.api.error.E0007.message,
                details: params[:id].to_i
            )
        end
        @user
    end

    #レスポンスのユーザー情報を作成する
    def create_user_response(user_id)
        User.joins(:roles).select('users.id, name, role, level')
            .where(id: user_id)
            .where('roles.enabled = true')
            .take 
    end

    def user_params
        params.require(:user).permit(:name, :password, :role)
    end

    def update_user_params
        params.require(:user).permit(:name, :password)
    end

    def update_role_params
        params.require(:user).permit(:role)
    end
end
