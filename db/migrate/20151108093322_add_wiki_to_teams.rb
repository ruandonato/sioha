class AddWikiToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :wiki, :string, default: "*Hello! My wiki is empty. :(*"
  end
end
