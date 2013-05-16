class CreateInteractiveModels < ActiveRecord::Migration
  def change
    create_table :interactive_models do |t|
      t.belongs_to :interactive, index: true
      t.belongs_to :model, index: true, :polymorphic => true

      t.timestamps
    end
  end
end
