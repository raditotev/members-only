class SessionsController < ApplicationController

  def index
    current_user
  end

  def new

  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      log_in user
      remember(user)
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
