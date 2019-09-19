class SessionsController < ApplicationController
  def new; end

  def create
    const_remember_me = Settings.remember_me
    email = (params_session :email).downcase
    password = params_session :password
    remember_me = params_session :remember_me
    user = User.find_by email: email
    if user&.authenticate(password)
      log_in user
      remember_me == const_remember_me ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = t ".invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  def params_session argument
    params[:session][argument]
  end
end
