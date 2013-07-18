class CreateInteractiveHstore < ActiveRecord::Migration
  def change
    create_table :interactives do |t|
      t.boolean :from_import, :default => false
      t.string :path
      t.string :group_key
      t.hstore :json_rep
      t.belongs_to :group, index: true
      t.string :revision

      t.timestamps
    end
  end
end
