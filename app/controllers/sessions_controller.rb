class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "Welcome back, Erin!"
      redirect_to root_path
    else
      flash[:notice] = "Ah ah ah, you didn't say the magic word."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "Au revoir!"
    redirect_to root_path
  end
end
