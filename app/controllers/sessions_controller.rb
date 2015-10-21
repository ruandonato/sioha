# File: sessions_controller.rb.
# Purpose: Controller that allow authentication for users
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class SessionsController < ApplicationController
  

  # action that renders the new page of the session controller
  def new
  end

  # this method creates a session to log a user
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

  # this method creates a session with a facebook account
  def createFacebook
    user = User.from_omniauth(env["omniauth.auth"])
    session[:user_id] = user.id
    redirect_to root_path
  end

  # this method destroys a session to log out a user
  def destroy
    if signed_in?
      sign_out
    else
      # nothing to do
    end
    redirect_to root_path
  end

end
