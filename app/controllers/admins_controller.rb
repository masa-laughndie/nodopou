class AdminsController < ApplicationController

  before_action :admin_user

  def index
    @for_param = params[:for].present? ? params[:for] : "list"
    @users = User.search(params[:keyword])
    @users_count = @users.size
    @users = @users.page(params[:page]).per(50)

    @lists = List.search(params[:keyword]).order(user_count: :desc)
    @lists_count = @lists.size
    @lists = @lists.page(params[:page]).per(50)
    
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
      return if current_user.admin?
      flash[:danger] = "権限がありません！"
      redirect_to root_path
    end
end
