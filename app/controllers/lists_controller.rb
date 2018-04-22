class ListsController < ApplicationController
  protect_from_forgery except: :update_active 

  before_action :logged_in_user
  before_action :get_user,                 except: [:update_active]
  before_action :set_and_check_list_exist, only:   [:show, :edit, :update]

  def index
    @user = User.find_by(account_id: params[:account_id])
    @lists = @user.lists.includes(:user)
  end

  def show
  end

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = "リストの作成が完了しました！"
      redirect_to @user
    else
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
    redirect_to lists_path(@user)
  end

  def update_active
    @list = current_user.lists.find_by(id: params[:id])
    if @list
      @list.toggle!(:active)
    else
      flash[:danger] = "権限がありません"
    end
    redirect_to lists_path(current_user)
  end

  def update_check
    @list = current_user.lists.find_by(id: params[:id])
    if @list
      @list.toggle!(:check)
      
      respond_to do |format|
        format.html { redirect_to lists_path(current_user) }
        format.js
      end
    else
      flash[:danger] = "権限がありません"
      redirect_to lists_path(current_user)
    end
  end

  private

    def list_params
      params.require(:list).permit(:content)
    end

    def get_user
      @user = current_user
    end

    def set_and_check_list_exist
      @list = List.find_by(id: params[:id])
      if @list
        @user = User.find_by(id: @list.user_id)
        @check = User.find_by(account_id: params[:account_id])
        if @user != @check
          flash[:danger] = "そのページは存在しません"
          redirect_to lists_path(@user)
        end
      else
        flash[:danger] = "そのページは存在しません"
        redirect_to root_path
      end
    end
end
