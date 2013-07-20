class CreateInteractiveSearches < ActiveRecord::Migration
  def change
    create_table :interactive_searches do |t|
      t.string :title
      t.string :subtitle
      t.string :about
      t.string :publicationStatus
      t.string :group_name
      t.string :group_category
      t.timestamps
    end
  end
end
