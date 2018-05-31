class SearchesController < ApplicationController

  before_action :logged_in_user

  def search
    @user = current_user
    @users = User.search(params[:keyword])
    @lists = List.search(params[:keyword]).order(user_count: :desc)
    unless params[:keyword].nil?
      @cuser_list_ids = current_user.mylists.includes(:list).pluck(:list_id)
    end
  end

end
