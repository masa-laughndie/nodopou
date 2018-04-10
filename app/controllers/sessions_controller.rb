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

end
