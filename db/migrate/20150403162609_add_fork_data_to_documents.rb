class AddForkDataToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :forked, :boolean, default: false
    add_column :documents, :forked_from, :string
  end
end
