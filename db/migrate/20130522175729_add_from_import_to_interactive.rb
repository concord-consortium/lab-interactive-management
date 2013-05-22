class AddFromImportToInteractive < ActiveRecord::Migration
  def change
    add_column :interactives, :from_import, :boolean, :default => false
  end
end
