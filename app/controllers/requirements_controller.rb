class RequirementsController < ApplicationController

  def show
    @requirement = Requirement.find(params[:id])
  end

  def new
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])
    @requirement = Requirement.new(team: @team, author: @user)
  end

  def create
    @team = Team.find(params[:team_id])
    @user = User.find(params[:user_id])

    @requirement = Requirement.new(requirement_params)
    @requirement.team = @team
    @requirement.author = @user

    if @requirement.save
      redirect_to @team
    else
      render 'new'
    end
  end

  private

  def requirement_params
    params.require(:requirement).permit(:code, :type, :description, :priority, :team_id, :user_id)
  end

end
