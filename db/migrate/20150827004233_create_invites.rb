class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.belongs_to :user
      t.belongs_to :team
    end
  end
end
