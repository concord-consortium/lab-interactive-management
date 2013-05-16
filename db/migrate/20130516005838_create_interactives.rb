class CreateInteractives < ActiveRecord::Migration
  def change
    create_table :interactives do |t|
      t.text :json_rep
      t.string :revision
      t.belongs_to :group, index: true

      t.timestamps
    end
  end
end
