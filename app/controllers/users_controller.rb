class UsersController < ApplicationController

  before_action :logged_in_user,       except: [:new, :create]
  before_action :check_user,           only:   [:show, :destroy]
  before_action :get_user,             only:   [:edit, :update,
                                                :email_edit, :email_update]
  before_action :check_user_authority, only:   :destroy

  def show
    @mylists = @user.mylists.where(active: true).includes(:list)
    @mylists_count = @mylists.size
    @list = current_user.create_lists.build
    @post = current_user.posts.build
    if current_user?(@user)
      #nilのときは全mylist
      current_user.confirm_and_reset_check_of(nil)
    else
      @cuser_list_ids = current_user.mylists.includes(:list).pluck(:list_id)
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(create_params)
    @user.validate_email = true
    @user.validate_password = true
    @user.set_create_params(params[:user])

    if @user.save
      log_in @user
      remember @user
      flash[:success] = "登録が完了しました！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def destroy
    List.transaction do
      @user.lists.each do |list|
        list.destroy_or_leaved(@user)
      end
      log_out
      @user.admin? ? raise : @user.destroy
    end
    flash[:success] = "アカウントの削除が完了しました。<br>ご利用ありがとうございました。"
    redirect_to root_path
  rescue => e
    flash[:danger] = "このユーザーは削除できません"
    redirect_to root_path
  end

  def edit
    @email_check = invalid_email?(@user.email) ? "check" : nil
  end

  def update
    @user.validate_name = true
    @user.validate_email = true
    @user.set_update_params(params[:user])

    if @user.update_attributes(edit_params)
      flash[:success] = "設定の変更が完了しました！"
      redirect_to setting_path
    else
      @user.check_blank(params[:user])
      render 'edit'
    end
  end

  def email_edit
    redirect_to setting_path
  end

  def email_update
    @user.validate_email = true

    if invalid_email?(params[:user][:email])
      @user.update_attribute(:is_send_email, false) if @user.is_send_email?
      flash.now[:danger] = "そのメールアドレスは無効です<br>変更してください"
      render 'edit'
    elsif @user.update_attributes(edit_email_params)
      @user.send_email(:email_update)
      flash[:success] = "メール設定の変更が完了しました！"
      redirect_to setting_path
    else
      @user.reload if params[:user][:email].blank?
      render 'edit'
    end
  end

  private

  def create_params
    params.require(:user).permit(:account_id, :name, :email,
                                  :password, :password_confirmation,
                                  :check_reset_at)
  end

  def edit_params
    params.require(:user).permit(:account_id, :name, :image, :image_cache,
                                  :profile, :password, :password_confirmation,
                                  :check_reset_time, :check_reset_at, :email)
  end

  def edit_email_params
    params.require(:user).permit(:email, :is_send_email)
  end

  def check_user_authority
    unless current_user?(@user)
      flash[:danger] = "権限がありません！！"
      redirect_to root_path
    end
  end

  def get_user
    @user = current_user
  end

  def invalid_email?(email)
    email.present? && email.match(/@example.com/).present?
  end
end
