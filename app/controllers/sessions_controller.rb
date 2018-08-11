class SessionsController < ApplicationController

  before_action :logged_in, only: [:new]

  def new
  end

  def create
    @user = find_user(params[:account_id])
    if @user && @user.authenticate(params[:password])
      log_in @user
      remember @user
      flash[:success] = "ログインに成功しました！"
      redirect_to @user
    else
      flash.now[:danger] = "NoDoBoIDまたはパスワードが間違っています。"
      render 'new'
    end
  end

  def omniauth_create
    if logged_in?
      @user = current_user
      @user.update_from_auth(auth_params)
      flash[:success] = "Twitter連携が完了しました！"
    else
      @user = User.find_or_create_from_auth(auth_params)
      log_in @user
      remember @user
      flash[:success] = @user.created_at > 1.minutes.ago ? "登録・ログインに成功しました！" : "ログインに成功しました！"
    end
    redirect_to @user
  end

  def destroy
    if logged_in?
      log_out
      flash[:success] = "ログアウトしました。"
    end
    redirect_to root_url
  end

  private

  def logged_in
    return unless logged_in?
    flash[:info] = "既にログイン中です。"
    redirect_to root_url
  end

  def auth_params
    request.env['omniauth.auth']
  end

  def find_user(param)
    User.find_by(account_id: param.downcase) || User.find_by(email: param.downcase)
  end
end
