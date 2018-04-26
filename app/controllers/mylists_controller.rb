class MylistsController < ApplicationController
  protect_from_forgery except: :update_active 

  before_action :logged_in_user
  before_action :check_user,                only: [:index, :show]
  before_action :check_user_authority,      only: [:edit, :update,
                                                   :update_active, :update_check]

  def index
    @mylists = @user.mylists.includes(:list).order(active: :desc)
  end

  def show
    unless @mylist = @user.mylists.find_by(id: params[:id])
      flash[:danger] = "そのページは存在しません"
      redirect_to mylists_path(@user)
    end
  end

  def create
    if @list = List.find_by(id: params[:id])
      current_user.avail(@list)
      flash[:success] = "リストの作成が完了しました！"
      redirect_to current_user
    else
      @user = current_user
      @lists = @user.lists.where(active: true)
      render 'users/show'
    end
  end

  def edit
  end

  def update
  end

  def destroy
    current_user.unavail(@list)
    unless @mylist.availed?
      @mylist.destroy
    end
    flash[:success] = "リストの削除に成功しました！"
    redirect_to lists_path(current_user)
  end

  def update_active
    @mylist.toggle!(:active)
    redirect_to mylists_path(current_user)
  end

  def update_check
    @mylist.toggle!(:check)
    
    respond_to do |format|
      format.html { redirect_to mylists_path(current_user) }
      format.js
    end
  end

  private

    def check_user_authority
      @mylist = current_user.mylists.find_by(id: params[:id])
      unless @mylist
        flash[:danger] = "権限がありません。"
        redirect_to root_path
      end
    end
end
