class SessionsController < ApplicationController
  before_action :set_permit_params, only: [:login]
  skip_before_action :require_signin, only: [:login, :new]

  def new
  end

  def login
    user = User.authenticate(@permit_params[:user_name], @permit_params[:password])

    if user.present?
      session[:user] = user
      redirect_to root_path, notice: 'You have been logged in successfully'
    else
      flash[:alert] = 'Please provide valid RPX SSO Credentials.'
      render :new
    end
  end

  def logout
    session[:user] = nil
    redirect_to new_session_path, notice: 'You have been logged out successfully.'
  end

  private

  def set_permit_params
    @permit_params = params.require(:user).permit(:user_name, :password)
  end
end
