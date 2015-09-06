class User < ActiveRecord::Base
  include Gravtastic
  gravtastic

  has_many :invites
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

  private

  def create_remember_token
    self.remember_token = User.digest(User.new_remember_token)
  end

end