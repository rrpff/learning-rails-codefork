class ChangeForkedFromToInteger < ActiveRecord::Migration
  def change
    change_column :documents, :forked_from, :integer
  end
end