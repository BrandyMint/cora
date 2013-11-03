class AddAuthHashToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_hash, :text
    add_column :users, :nickname, :string
    add_column :users, :avatar_url, :string
  end
end
