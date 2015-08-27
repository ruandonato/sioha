class AddPendingToInvites < ActiveRecord::Migration
  def change
    add_column :invites, :pending, :boolean, :default => true
  end
end
