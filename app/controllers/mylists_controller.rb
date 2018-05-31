class MylistsController < ApplicationController

  before_action :logged_in_user,       except: :index
  before_action :check_user,           only: [:index, :show]
  before_action :check_user_authority, only: [:edit, :update,
                                              :update_active, :update_check]

  def index
    @og_image_url = @user.og_image_url
    @mylists = @user.mylists.includes(:list).order(active: :desc)
    if logged_in? && current_user?(@user)
      current_user.confirm_and_reset_check_of(@mylists)
    elsif logged_in?
      @cuser_list_ids = current_user.mylists.includes(:list).pluck(:list_id)
    else
      @cuser_list_ids = []
    end
  end

  def show
    unless @mylist = @user.mylists.find_by(id: params[:id])
      flash[:danger] = "そのページは存在しません"
      redirect_to mylists_user_path(@user)
    end
  end

  def create
    if @list = List.find_by(id: params[:list_id])
      current_user.avail(@list)
      respond_to do |format|
        format.html { redirect_to mylists_user_path(current_user) }
        format.js
      end
    else
      flash[:danger] = "そのリストは既に存在しません"
      redirect_to current_user
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @list = List.find_by(id: params[:id])
    @list.destroy_or_leaved(current_user)

    respond_to do |format|
      format.html { redirect_to mylists_user_path(current_user) }
      format.js
    end
  end

  def update_active
    @mylist.toggle!(:active)
    
    respond_to do |format|
      format.html { redirect_to mylists_user_path(current_user) }
      format.js
    end
  end

  def update_check
    @mylist.toggle_check_and_count!
    
    respond_to do |format|
      format.html { redirect_to mylists_user_path(current_user) }
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
