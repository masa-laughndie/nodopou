class PasswordResetsController < ApplicationController

  before_action :valid_user,       only: :login
  before_action :check_expiration, only: :login

  def new
  end

  def create
    @user = User.find_by(email: params[:email].downcase)
    if @user
      @user.create_reset_digest_and_etoken
      @user.send_email(:password_reset)
      redirect_to confirm_password_reset_path
    else
      if params[:email].blank?
        flash.now[:danger] = "メールアドレスを入力してください"
      else
        flash.now[:danger] = "そのメールアドレスは登録されていません"
      end
      render 'new'
    end
  end

  def login
    log_in @user
    remember @user
    @user.update_attributes(reset_digest: nil, e_token: nil)
    flash[:success] = "仮ログインが完了しました！<br>パスワードの再設定を行ってください！"
    redirect_to setting_url
  end

  def confirm
  end

  private

    def valid_user
      @user = User.find_by(e_token: params[:e_token])
      unless (@user && @user.authenticated?(:reset, params[:rst]))
        flash[:danger] = "そのページへはアクセスできません"
        redirect_to root_url
      end
    end

    def check_expiration
      if @user.password_reset_expired?
        @user.update_attributes(reset_token: nil, e_token: nil)
        flash[:danger] = "仮ログインuRLの有効時間を過ぎています<br>再度、URLの発行をしてください"
        redirect_to new_password_reset_url
      end
    end

end
