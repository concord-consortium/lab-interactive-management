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

  def ordered_attributes
    # TODO: Need to ask how the interactive JSON files are generated to determine how the properties are ordered
    # for now, using this script, used_interactive_properties.rb , to find ordering
    ordered_attrs = { }
    %w{ path title publicationStatus subtitle about fontScale models outputs filteredOutputs parameters exports components layout template }.each do |attr_name|
      ordered_attrs[attr_name] = send(attr_name.to_sym)
    end
    #ordered_attrs.merge(self.attributes)
    ordered_attrs
  end
end
