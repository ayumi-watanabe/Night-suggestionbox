module SessionsHelper
   # Logs in the given user.
  def log_in(user)
    session[:user_id] = user.id
  end

  # Returns true if the given user is the current user.
  def current_user?(user)
    user == current_user
  end
  
  # Returns the current logged-in user (if any).
  def current_user # after log_in -> current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil? # is there NO EMPTY current_user? Is there a current_user?
    # is the current user empty? TRUE
    # is the current user NOT empty? FALSE
  end

  # Logs out the current user.
  def log_out
    session.delete(:user_id) # deletes memory in browser
    @current_user = nil       # deletes you as current_user
  end

  def only_loggedin_users
    redirect_to login_url unless logged_in?
    end

end
