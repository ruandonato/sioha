class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :login
      t.string :description
      t.string :about
      t.string :remember_token
      t.string :password_digest
    end
  end
end
