module SessionsHelper

  def log_in(user)
    session[:aid] = user.id
  end

  def remember(user)
    #remember_tokenを発行し、userのDBにrember_digest(tokenのハッシュ化)を保存
    user.remember
    cookies.permanent.signed[:aid] = { value: user.id, httponly: true }
    cookies.permanent[:remember_token] = { value: user.remember_token, httponly: true }
  end

  def current_user?(user)
    user == current_user
  end

  def current_user
    if (aid = session[:aid])
      @current_user ||= User.find_by(id: aid)
    elsif (aid = cookies.signed[:aid])
      user = User.find_by(id: aid)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def forget(user)
    user.forget
    cookies.delete(:aid)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_user)
    session.delete(:aid)
    @current_user = nil
  end

end
