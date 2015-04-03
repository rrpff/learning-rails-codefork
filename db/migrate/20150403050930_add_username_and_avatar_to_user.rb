class AddUsernameAndAvatarToUser < ActiveRecord::Migration
  def change
    remove_column :users, :name
    add_column :users, :username, :string, index: true
    add_column :users, :avatar, :string
  end
end
