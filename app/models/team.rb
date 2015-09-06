class Team < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :invites
  has_many :members, through: :invites, source: :user
  belongs_to :user
  validates :name, length: { minimum: 6, maximum: 50 }
  validates :description, length: { minimum: 10, maximum: 50 }
  validates :name, uniqueness: true

  def pending_invites
    @invites = Invite.where(team: self, pending: true)
    @invites += Invite.where(team: self, pending: nil)
  end

end