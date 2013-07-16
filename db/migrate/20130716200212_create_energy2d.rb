class CreateEnergy2d < ActiveRecord::Migration
  def change
    create_table :energy2ds do |t|
      t.text :json_rep
      t.string :revision
      t.boolean :from_import
    end
  end
end
