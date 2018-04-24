class ListsController < ApplicationController
  protect_from_forgery except: :update_active 

  before_action :logged_in_user
  before_action :set_and_check_list_exist, only: :show
  before_action :check_user_authority,     only: [:edit, :update,
                                                  :update_active, :update_check]

  def index
    @user = User.find_by(account_id: params[:account_id])
    @lists = @user.lists.order(active: :desc)
  end

  def show
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = "リストの作成が完了しました！"
      redirect_to current_user
    else
      @user = current_user
      render 'users/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @list.destroy
    flash[:success] = "リストの削除に成功しました！"
    redirect_to lists_path(current_user)
  end

  def update_active
    @list.toggle!(:active)
    redirect_to lists_path(current_user)
  end

  def update_check
    @list.toggle!(:check)
    
    respond_to do |format|
      format.html { redirect_to lists_path(current_user) }
      format.js
    end
  end

  private

    def list_params
      params.require(:list).permit(:content)
    end

    def set_and_check_list_exist
      @user = User.find_by(account_id: params[:account_id])
      if !@user
        flash[:danger] = "そのページは存在しません"
        redirect_to root_path
      elsif !(@list = @user.lists.find_by(id: params[:id]))
        flash[:danger] = "そのページは存在しません"
        redirect_to lists_path(@user)
      end
    end

    def check_user_authority
      @list = current_user.lists.find_by(id: params[:id])
      unless @list
        flash[:danger] = "権限がありません。"
        redirect_to root_path
      end
    end
end
