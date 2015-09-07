class AddPublicToMembersToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :public_to_members, :boolean, :default => false
  end
end
