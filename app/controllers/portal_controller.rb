# File: portal_controller.rb.
# Purpose: Contains initial Sioha pages
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class PortalController < ApplicationController

  def index
    if signed_in?
      @invites = Invite.where(user: current_user, pending: true)
      @invites += Invite.where(user: current_user, pending: nil)
    end
    @teams = Team.where(public_to_members: true)
    @teams = @teams.last(5)
    @users = User.last(5)
  end

end