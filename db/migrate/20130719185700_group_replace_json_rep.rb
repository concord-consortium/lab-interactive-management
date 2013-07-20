class GroupReplaceJsonRep < ActiveRecord::Migration
  change_table :groups do |t|
    t.remove :json_rep
    t.string :name
    t.string :path
    t.string :category
  end
end
