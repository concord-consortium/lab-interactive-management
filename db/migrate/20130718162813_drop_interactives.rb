class DropInteractives < ActiveRecord::Migration
  def change
    drop_table :interactives
  end
end
