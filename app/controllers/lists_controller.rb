class ListsController < ApplicationController

  before_action :logged_in_user
  before_action :check_list,           only: :show
  before_action :check_user_authority, only: :destroy

  def show
  end

  def create
    @list = current_user.create_lists.build(list_params)
    if @list.save
      current_user.avail(@list)
      flash[:success] = "リストの作成が完了しました！"
      redirect_to current_user
    else
      @user = current_user
      @mylists = @user.mylists.where(active: true)
      render 'users/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    current_user.unavail(@list)
    unless @list.availed?
      @list.destroy
    else
      @list.set_create_user_none
    end
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
