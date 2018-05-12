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
    @user.validate_password = true

    @user.set_name_and_email(params[:user][:account_id])
    @user.set_pass_and_time(params[:user][:password], nil)

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
    @user.lists.each do |list|
      list.destroy_or_leaved(@user)
    end

    log_out
    @user.destroy
    flash[:success] = "アカウント削除が完了しました。"
    redirect_to root_path
  end

  def edit
  end

  def update
    @user.validate_name = true

    @user.set_pass_and_time(params[:user][:password],
                            params[:user][:check_reset_time])

    if @user.update_attributes(edit_params)
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
      if @user.is_send_email?
        @user.update_attribute(:is_send_email, false)
      end
      flash.now[:danger] = "そのメールアドレスは無効です<br>変更してください"
      render 'edit'

    elsif @user.update_attributes(edit_email_params)
      @user.send_email(:email_update)
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

    def create_params
      params.require(:user).permit(:account_id, :name, :email,
                                   :password, :password_confirmation,
                                   :check_reset_at)
    end

    def edit_params
      params.require(:user).permit(:account_id, :name, :image, :image_cache,
                                   :profile, :password, :password_confirmation,
                                   :check_reset_time, :check_reset_at)
    end

    def edit_email_params
      params.require(:user).permit(:email, :is_send_email)
    end

    def admin_user
      redirect_to root_path unless current_user.admin?
    end

    def check_user_authority
      unless current_user?(@user) || current_user.admin?
        flash[:danger] = "権限がありません！！"
        redirect_to root_path
      end
    end

    def get_user
      @user = current_user
    end
end
