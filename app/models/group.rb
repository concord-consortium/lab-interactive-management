class Group < ActiveRecord::Base
  include ::GroupStore

  has_many :interactives


  def presenter
    # trickery to get the serialized attribute, json_rep, to show up
    # as if its a top level attribute
    json_rep_hash = self.json_rep
    # here's the models, not serialized, attributes
    presenter_hash = self.attributes.delete('json_rep')
    presenter_hash.merge(json_rep)
  end
end
