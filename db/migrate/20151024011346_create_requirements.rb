class CreateRequirements < ActiveRecord::Migration
  def change
    create_table :requirements do |t|
      t.integer :author_id
      t.belongs_to :team
      t.string :type
      t.integer :priority
      t.string :description
      t.string :code

      t.timestamps null: false
    end
  end
end
