class ListsController < ApplicationController

  before_action :logged_in_user
  before_action :check_list,           only: :show
  before_action :check_user_authority, only: :destroy

  def show
    users = @list.users
    # lists.user_count調整
    if @list.check_correct_user_count_and_destroy?(users.size)
      flash[:danger] = "ページが存在しませんでした"
      redirect_to current_user
    end

    @users  = users.order("mylists.check_count DESC").take(3)
    @mylists = @list.mylists.order(check_count: :desc).take(3)
    @cuser_list_ids = current_user.mylists.includes(:list).pluck(:list_id)
  end

  def create
    @list = current_user.create_lists.build(list_params)
    if params[:list][:content].length > 60
      flash[:danger] = "文字数制限を超えています！"
    elsif @list.save
      current_user.avail(@list)
      flash[:success] = "リストの作成が完了しました！"
    else
      flash[:danger] = "リストを追加できませんでした<br>リストの内容を入力してください"
    end
    redirect_to current_user
  end

  def edit
  end

  def update
  end

  def destroy
    @list.destroy_or_leaved(current_user)
    flash[:success] = "リストの削除に成功しました！"
    redirect_to current_user
  end

  private

    def list_params
      params.require(:list).permit(:content)
    end

    def check_user_authority
      @list = current_user.create_lists.find_by(id: params[:id])
      unless @list
        flash[:danger] = "権限がありません。"
        redirect_to root_path
      end
    end

end
