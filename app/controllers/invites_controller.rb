#
# Purpose: Map actions relative to invite model
class InvitesController < ApplicationController

  before_action :require_login

  def index
    @all_invites = Invite.where(user: current_user)
    @accepted_invites = @all_invites.where(accepted: true)
    @pending_invites = @all_invites.where(pending: true)
    @invites = @pending_invites
  end

end