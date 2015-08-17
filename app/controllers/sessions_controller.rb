class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user
    else
      flash[:error] = 'Invalid combination.'
      render 'new'
    end
  end

  def destroy
    unless !signed_in?
      sign_out
      puts "#{signed_in?}"*20
      redirect_to root_path
    end
  end
end
















