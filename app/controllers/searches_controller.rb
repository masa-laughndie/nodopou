class SearchesController < ApplicationController

  before_action :logged_in_user

  def search
    @user = current_user
    @users = User.search(params[:keyword])
    @lists = List.search(params[:keyword]).includes(:user)
  end

end
