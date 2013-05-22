class AddFromImportToMd2d < ActiveRecord::Migration
  def change
    add_column :md2ds, :from_import, :boolean, :default => false
  end
end
