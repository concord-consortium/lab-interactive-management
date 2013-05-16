class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.text :json_rep
      t.text :revision

      t.timestamps
    end
  end
end
