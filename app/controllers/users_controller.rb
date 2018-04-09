class UsersController < ApplicationController

  def show
    @user = User.find_by(account_id: params[:account_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.validate_password = true
    @user.name = params[:user][:account_id]
    @user.password_confirmation = params[:user][:password]
    if @user.save
      flash[:success] = "登録が完了しました！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destory
  end

  def edit
  end

  def update
  end

  private

    def user_params
      params.require(:user).permit(:account_id, :name,
                                   :password, :password_confirmation)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end
end
