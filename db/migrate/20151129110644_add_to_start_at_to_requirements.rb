class AddToStartAtToRequirements < ActiveRecord::Migration
  def change
    add_column :requirements, :to_start_at, :date, default: Time.now
  end
end
