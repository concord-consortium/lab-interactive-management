class CreateInteractiveIndex < ActiveRecord::Migration
  def up
    execute "CREATE INDEX interactives_json_rep ON interactives USING GIN(json_rep)"
  end

  def down
    execute "DROP INDEX interactives_json_rep"
  end
end
