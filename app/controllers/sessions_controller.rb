# File: sessions_controller.rb.
# Purpose: Controller that allow authentication for users
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class SessionsController < ApplicationController
  
  def new
  end

  # authenticate the creation of an users
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to root_path
    else
      flash[:danger] = 'Invalid combination.'
      render 'new'
    end
  end

  # allow the user to logoff from the system
  def destroy
    unless !signed_in?
      sign_out
    end
    redirect_to root_path
  end

end
