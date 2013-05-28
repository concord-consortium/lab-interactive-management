class Md2d < ActiveRecord::Base
  # does all magic for serialized attributes
  include Md2dStore

  def gen_new_url
    self.url = json_rep['url'].gsub("/","_").gsub('$','_').gsub(/^_/,"").gsub('.json','')
  end

  def gen_image_path
    self.json_rep['imagePath'] = self.json_rep['url'].gsub(/^\//, '').match(/.*\//)[0];
  end

  def self.find_by_url(url)
    find do |g|
      g if g.json_rep['url'] == url
    end
  end

  def presenter
    # trickery to get the serialized attribute, json_rep, to show up
    # as if its a top level attribute
    json_rep_hash = self.json_rep
    # here's the models, not serialized, attributes
    presenter_hash = self.attributes.delete('json_rep')
    presenter_hash.merge(json_rep)
  end

end
