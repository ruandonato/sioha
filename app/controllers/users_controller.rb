# File: users_controller.rb.
# Purpose: Map actions relative to user model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  before_action :require_login, only: [:edit, :update]

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = 'Informações alteradas!'
      redirect_to @user
    else
      render 'edit'
    end
  end

  def show
    @user = User.find(params[:id])
    @teams = @user.teams
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :login, :description, :about,
                                 :password, :password_confirmation, :picture,
                                 :public_email)
  end

end

