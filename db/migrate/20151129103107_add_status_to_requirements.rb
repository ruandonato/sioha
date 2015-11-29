class AddStatusToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :status, :string, default: "to-do"
  end
end
