class ListsController < ApplicationController

  before_action :logged_in_user
  before_action :get_user

  def create
    @list = current_user.lists.build(list_params)
    if @list.save
      flash[:success] = "リストの作成が完了しました！"
      redirect_to @user
    else
      render 'users/show'
    end
  end

  def index
  end

  private

    def list_params
      params.require(:list).permit(:content)
    end

    def get_user
      @user = current_user
    end
end
