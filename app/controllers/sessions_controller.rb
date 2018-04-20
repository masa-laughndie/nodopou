class SessionsController < ApplicationController

  before_action :logged_in, only: [:new]

  def new
  end

  def create
    @user = User.find_by(account_id: params[:account_id].downcase)
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
    @user = User.find_or_create_from_auth(auth_params)
    log_in @user
    remember @user
    if @user.created_at > 1.minutes.ago
      flash[:success] = "登録・ログインに成功しました！"
    else
      flash[:success] = "ログインに成功しました！"
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
      if logged_in?
        flash[:info] = "既にログイン中です。"
        redirect_to root_url
      end
    end

    def auth_params
      request.env['omniauth.auth']
    end

end
