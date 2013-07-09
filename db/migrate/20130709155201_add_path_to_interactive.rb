class AddPathToInteractive < ActiveRecord::Migration
  def change
    add_column :interactives, :path, :string
  end
end
