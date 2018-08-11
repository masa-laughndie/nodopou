class StaticsController < ApplicationController
  
  def home
    redirect_to current_user if logged_in?
  end

  def terms
  end

  def privacy
  end

  def about
  end

  def help
  end
end
