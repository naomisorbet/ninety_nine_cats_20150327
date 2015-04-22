class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user
  
  def already_logged_in
    if current_user
      flash[:notices]="You're already logged in!  You may sign out first to visit that page."
      redirect_to cats_url
    end
  end
  
  def current_user
    @current_user ||= User.find_by_session_token(session[:token])
  end
  
  def login!(user)
    @current_user = user
    session[:token] = user.session_token
  end
  
end
