class TeamsController < ApplicationController

  before_action :require_login
  before_action :only_members, only: [:show, :invite]

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
    @invites = @team.pending_invites
  end

  def index
    @teams = Team.all
  end

  def invite
    @team = Team.find(params[:id])
    @users = User.search(params[:keyword], params[:filter])
  end

  def invite_member
    @team = Team.find(params[:id])
    @user = User.find(params[:user_id])
    @invite = Invite.new(user: @user, team: @team, pending: true)
    @invite.save
    redirect_to @team
  end

  def accept_invite
    @user = User.find(params[:id])
    @invite = Invite.find(params[:invite_id])
    @invite.pending = false
    @invite.save
    redirect_to @invite.team
  end

  def refuse_invite
    @user = User.find(params[:id])
    @invite = Invite.find(params[:invite_id])
    @invite.pending = true
    @invite.save
    redirect_to @invite.team
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :user_id)
  end

  def only_members
    @team = Team.find(params[:id])
    unless @team.user == current_user
      if current_user.pending_to?(@team) || current_user.pending_to?(@team) == nil
        flash[:danger] = "Você precisa ser um membro deste time."
        redirect_to teams_path
      else
        flash[:success] = "Você já é membro!"
      end
    end
  end

end