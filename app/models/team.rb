# File: team.rb.
# Purpose: The team model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.


class Team < ActiveRecord::Base
  include Gravtastic
  gravtastic

  validate  :picture_size
  has_many :requirements
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

  def upstream_traceability_scope(type)
    if type == "UserStory"
      return this.requirements.features
    elsif type == "InvestimentTheme"
      # investiment themes dont have a upstream traceability
    elsif type == "Feature"
      return this.requirements.features
    end
  end

  def downstream_traceability_scope(type)
    if type == "UserStory"
      # stories dont have an downstream traceability
    elsif type == "InvestimentTheme"
      return this.requirements.features
    elsif type == "Feature"
      return this.requirements.stories
    end
  end

  # this method checks if the image size is larger than 5 megabytes
  private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    else
      # nothing to do
    end
  end

end
