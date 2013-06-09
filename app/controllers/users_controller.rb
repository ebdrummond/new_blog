class UsersController < ApplicationController
  before_filter :authorize

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_attributes(params[:user])

    if @user.save
      flash[:notice] = "Your information has been updated."
      redirect_to root_path
    else
      flash[:notice] = "Oh noes!  Something went wrong."
      render :edit
    end
  end
end