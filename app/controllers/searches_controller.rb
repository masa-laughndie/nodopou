class SearchesController < ApplicationController

  before_action :logged_in_user

  def search
    @user = current_user
    @lists = List.search(params[:keyword]).order(user_count: :desc)
    @lists_count = @lists.size
    @lists = @lists.page(params[:page]).per(30)
    @cuser_list_ids = current_user.mylists.includes(:list).pluck(:list_id)
  end
end
