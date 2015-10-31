class Requirement < ActiveRecord::Base
  belongs_to :team
  belongs_to :author, class_name: "User"

  has_many :upstream_traceability, class_name: "Requirement"
  has_many :downstream_traceability, class_name: "Requirement"

  has_many :member_of, through: :team_members, source: :team

  validates :code, length: { minimum: 2, maximum: 50 }
  validates :description, length: { minimum: 2, maximum: 1000 }
  validates :type, presence: true
  validates :priority, presence: true
  validates :author_id, presence: true
  validates :team_id, presence: true

  scope :features, -> { where(type: "Feature") }
  scope :stories, -> { where(type: "UserStory") }
  scope :investiment_themes, -> { where(type: "InvestimentTheme") }

end
