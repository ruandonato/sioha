class Team < ActiveRecord::Base
  include Gravtastic
  gravtastic

  validate  :picture_size

  mount_uploader :picture, PictureUploader
  has_many :invites

  # has_many :members, through: :invites, source: :user
  has_many :team_members
  has_many :members, through: :team_members, source: :user

  belongs_to :user
  validates :name, length: { minimum: 6, maximum: 50 }
  validates :description, length: { minimum: 10, maximum: 50 }
  validates :name, uniqueness: true

  def pending_invites
    @invites = Invite.where(team: self, pending: true)
    @invites += Invite.where(team: self, pending: nil)
  end

  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end