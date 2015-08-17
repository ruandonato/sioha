class AddRememberTokenToUsers < ActiveRecord::Migration

  def change
    add_column :users, :remember_token, :string
    add_index  :users, :remember_token
  end

  def change
    add_column :users, :password_digest, :string
    add_column :users, :remember_digest, :string
  end

end
