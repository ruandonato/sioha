class AddEmailToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :email, :string
  end
end
