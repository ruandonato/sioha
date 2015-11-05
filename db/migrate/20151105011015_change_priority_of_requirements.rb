class ChangePriorityOfRequirements < ActiveRecord::Migration
  def change
    change_column :requirements, :priority, :string
  end
end
