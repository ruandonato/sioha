class CreateTeamMembers < ActiveRecord::Migration
  def change
    create_table :team_members do |t|
      t.belongs_to :user
      t.belongs_to :team
    end
  end
end
