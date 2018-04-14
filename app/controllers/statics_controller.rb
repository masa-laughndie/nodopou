class StaticsController < ApplicationController
  
  def home
    if logged_in?
      redirect_to current_user
    end
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
