class AccountActivationsController < ApplicationController
  before_action :load_user, only: :edit

  def edit
    if !@user.activated? && @user.authenticated?(:activation, params[:id])
      user.activate
      log_in @user
      flash[:success] = t ".actived_success"
      redirect_to @user
    else
      flash[:danger] = t ".actived_faild"
      redirect_to root_url
    end
  end

  private

  def load_user
    @user = User.find_by email: params[:email]
    return if @user
    flash[:danger] = t ".not_found_user"
    redirect_to root_url
  end
end
