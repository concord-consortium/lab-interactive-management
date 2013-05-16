class Interactive < ActiveRecord::Base
  # does all magic for serialized attributes
  include InteractiveStore

  belongs_to :group

  has_many :interactive_models
  has_many :md2ds, :through => :interactive_models, :source => 'model',  :source_type => 'Md2d'

  def gen_new_path
    self.path = json_rep['path'].gsub("/","_").gsub('$','_').gsub(/^_/,"").gsub('.json','')
  end

  def gen_new_model_paths
    self.json_rep['models'].each do |m_hash|
      m_hash['url'] = m_hash['url'].gsub("/","_").gsub('$','_').gsub(/^_/,"").gsub('.json','')
    end
  end

  def presenter
    # trickery to get the serialized attribute, json_rep, to show up
    # as if its a top level attribute
    json_rep_hash = self.json_rep
    # here's the models, not serialized, attributes
    presenter_hash = self.attributes.delete('json_rep')
    presenter_hash.merge(json_rep)
    presenter_hash['models'].each do |m|
      m['url'] = "webapp/models/md2ds/#{m['url']}"
    end
    presenter_hash
  end
end
