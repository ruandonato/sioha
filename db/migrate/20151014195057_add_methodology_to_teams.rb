class AddMethodologyToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :methodology, :string
  end
end
