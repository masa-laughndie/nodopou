class AdminsController < ApplicationController

  before_action :admin_user

  def index
    if params[:for].blank?
      @for_param = "list"
    else
      @for_param = params[:for]
    end
    @users = User.search(params[:keyword])
    @lists = List.search(params[:keyword]).order(user_count: :desc)
    @cuser_list_ids = []
  end

  def user_destroy
    user = User.find(params[:id])
    if user.admin?
      flash[:danger] = "そのユーザーは削除できません。"
    else
      user.destroy
      flash[:success] = "ユーザーの削除が完了しました。"
    end
    redirect_to admins_path
  end

  def list_destroy
    list = List.find(params[:id])
    list.destroy
    flash[:success] = "リストの削除が完了しました。"
    redirect_to admins_path
  end

  private

    def admin_user
      unless current_user.admin?
        flash[:danger] = "権限がありません！"
        redirect_to root_path
      end
    end
end
