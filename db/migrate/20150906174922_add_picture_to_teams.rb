class AddPictureToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :picture, :string
  end
end
