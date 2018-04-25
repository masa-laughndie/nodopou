class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def check_user
    @user = User.find_by(account_id: params[:account_id])
    unless @user
      flash[:danger] = "そのページは存在しません"
      redirect_to current_user
    end
  end

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "ログインしてください！"
        redirect_to login_url
      end
    end

    def not_found
      raise ActionContorller::RoutingError.new('Not Found')
    end
end
