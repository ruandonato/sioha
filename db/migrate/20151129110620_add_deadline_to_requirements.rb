class AddDeadlineToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :deadline, :date, default: Time.now
  end
end
