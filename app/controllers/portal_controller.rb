class PortalController < ApplicationController

  def index
    if signed_in?
      @invites = Invite.where(user: current_user, pending: true)
      @invites += Invite.where(user: current_user, pending: nil)
    end
  end

end