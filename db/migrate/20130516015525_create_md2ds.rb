class CreateMd2ds < ActiveRecord::Migration
  def change
    create_table :md2ds do |t|
      t.text :json_rep
      t.string :revision

      t.timestamps
    end
  end
end
