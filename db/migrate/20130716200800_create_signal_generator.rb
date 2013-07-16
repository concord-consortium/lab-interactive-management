class CreateSignalGenerator < ActiveRecord::Migration
  def change
    create_table :signal_generators do |t|
      t.text :json_rep
      t.string :revision
      t.boolean :from_import
    end
  end
end
