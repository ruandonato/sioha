class TeamsController < ApplicationController
 
 before_action :require_login
 
  def new 
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @team.user = current_user
    if(@team.save)
      redirect_to @team
    else
      render 'new'
    end
  end

  def show
    @team = Team.find(params[:id])
  end

  def index
    @teams = Team.all
  end

  private 

  def team_params
    params.require(:team).permit(:name, :description, :user_id)
  end
end