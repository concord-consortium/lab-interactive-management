class InteractiveModel < ActiveRecord::Base
  belongs_to :interactive
  belongs_to :model, :polymorphic => true
end
