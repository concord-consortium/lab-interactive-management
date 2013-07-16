class CreateSolarSystem < ActiveRecord::Migration
  def change
    create_table :solar_systems do |t|
      t.text :json_rep
      t.string :revision
      t.boolean :from_import
    end
  end
end
