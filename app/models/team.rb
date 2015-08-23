class Team < ActiveRecord::Base
  belongs_to :user
  validates :name, length: { minimum: 6, maximum: 50 }
  validates :description, length: { minimum: 10, maximum: 50 }
end