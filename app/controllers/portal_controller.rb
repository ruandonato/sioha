class PortalController < ApplicationController

  def index
    if signed_in?
      @invites = Invite.where(user: current_user, pending: true)
      @invites += Invite.where(user: current_user, pending: nil)
      @teams = Team.last(5)
      @users = User.last(5)
    else
      @teams = Team.last(5)
      @users = User.last(5)
    end
  end

end