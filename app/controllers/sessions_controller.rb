class SessionsController < ApplicationController
  
  before_action :already_logged_in, only: [:new]
  
  def new
  end

  def create
    @user = User.find_by_credentials(params[:user][:username], 
                                     params[:user][:password])
    if @user
      login!(@user)
      redirect_to user_url(@user)
    else flash.now[:message] = "Credentials were wrong--please try again."
    end
  end
  
  def destroy 
    User.find_by_session_token(session[:token]).reset_session_token!
    session[:token] = nil
    flash[:notices] = "Logout successful"
    redirect_to new_sessions_url
  end
end
