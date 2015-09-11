# File: user.rb.
# Purpose: The user model.
# License: GPL v3.
# Sioha Group.
# FGA - UnB Faculdade de Engenharias do Gama - Universidade de Brasília.

class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  validate  :picture_size
  mount_uploader :picture, PictureUploader

  has_many :invites
  has_many :team_members
  has_many :member_of, through: :team_members, source: :team
  has_many :teams
  before_create :create_remember_token
  validates :password, length: { minimum: 6, maximum: 100 }
  validates :name, length: { maximum: 50 }
  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, format: { with: valid_email_regex }
  validates :email, uniqueness: true
  has_secure_password

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.search(keyword, filter = nil)
    if keyword
      aux = User.where("name LIKE ?", "%#{keyword}%")
      puts "aux: #{aux}"
    else
      aux = User.all
    end

    return aux
  end

  def pending_to?(team)
    invite = Invite.find_by(team: team, user: self)
    if invite
      invite.pending # true = invited but not accepted, false = invited and accepted
    else
      nil # nil = the invite isn't even created
    end
  end

  def member_of?(team)
    team.members.include?(self)
  end

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end

end