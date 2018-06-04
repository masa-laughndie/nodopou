class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  private

    def logged_in_user
      unless logged_in?
        flash[:danger] = "登録またはログインしてください！"
        redirect_to root_url
      end
    end

    def check_user
      @user = User.find_by(account_id: params[:account_id])
      unless @user
        flash[:danger] = "そのページは存在しません"
        redirect_to current_user
      end
    end

    def check_list
      @list = List.find_by(id: params[:id])
      unless @list
        flash[:danger] = "そのページは存在しません"
        redirect_to current_user
      end
    end

    def not_found
      raise ActionContorller::RoutingError.new('Not Found')
    end
end
