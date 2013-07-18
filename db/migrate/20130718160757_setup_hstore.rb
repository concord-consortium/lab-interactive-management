class SetupHstore < ActiveRecord::Migration
  def self.up
    execute "CREATE EXTENSION IF NOT EXISTS hstore"
    # enable_extenstion 'hstore'
  end

  def self.down
    execute "DROP EXTENSION IF EXISTS hstore"
    #disable_extenstion 'hstore'
  end
end
