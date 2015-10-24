class Requirement < ActiveRecord::Base
  belongs_to :team
  belongs_to :author, class_name: "User"

  has_many :upstream_traceability, class_name: "Requirement"
  has_many :downstream_traceability, class_name: "Requirement"

  has_many :member_of, through: :team_members, source: :team

end
