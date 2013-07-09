class AddGroupKeyToInteractive < ActiveRecord::Migration
  def change
    add_column :interactives, :group_key, :string
  end
end
