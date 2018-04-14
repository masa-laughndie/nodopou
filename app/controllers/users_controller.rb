class UsersController < ApplicationController

  before_action :logged_in_user, only: :destroy
  before_action :admin_user,     only: :destroy
  before_action :get_user,       only: [:edit, :update, :email_update]

  def show
    @user = User.find_by(account_id: params[:account_id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.validate_password = true

    @user.set_name_and_email(params[:user][:account_id])
    @user.password_confirmation = params[:user][:password]

    if @user.save
      log_in @user
      remember @user
      flash[:success] = "登録が完了しました！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destory
    @user = User.find_by(account_id: params[:account_id])
    @user.destroy
    flash[:success] = "削除が完了しました。"
    redirect_to root_path
  end

  def edit
  end

  def update
    @user.validate_name = true
    unless params[:user][:password].nil?
      @user.validate_password = true
      @user.password_confirmation = params[:user][:password]
    end
    if @user.update_attributes(user_edit_params)
      flash[:success] = "設定の変更が完了しました！"
      redirect_to setting_path
    else
      if params[:user][:name].blank? || params[:user][:account_id].blank?
        @user.reload
      end
      render 'edit'
    end
  end

  def email_edit
    redirect_to setting_path
  end

  def email_update
    @user.validate_email = true
    address = params[:user][:email]
    if address.present? && address.match(/@example.com/).present?
      if @user.is_send_email
        @user.update_attribute(:is_send_email, false)
      end
      flash.now[:danger] = "そのメールアドレスは無効です<br>変更してください"
      render 'edit'
    elsif @user.update_attributes(user_email_params)
      flash[:success] = "メール設定の変更が完了しました！"
      redirect_to setting_path
    else
      if address.blank?
        @user.reload
      end
      render 'edit'
    end
  end

  private

    def user_params
      params.require(:user).permit(:account_id, :name, :email,
                                   :password, :password_confirmation)
    end

    def user_edit_params
      params.require(:user).permit(:account_id, :name, :image, :image_cache,
                                   :profile, :password, :password_confirmation)
    end

    def user_email_params
      params.require(:user).permit(:email, :is_send_email)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def get_user
      @user = current_user
    end
end
