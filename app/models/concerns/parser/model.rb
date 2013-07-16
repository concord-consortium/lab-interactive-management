module Parser
  class Model < Base
    attr_reader :model_hash

    def initialize(url, model_hash = {})
      super(url)
      # model_hash contains json defined in a specific interactive json file
      # for this model. Note: part of the model is defined in the interactive
      # json file and the other part, most, is defined in a json for this model
      # model
      @model_hash = model_hash.dup
    end

    def create_model(model_instance)
      # read the contents of one model json file
      puts "Reading Model JSON from #{uri}/#{model_hash['url']}"
      file_attr_hash = JSON.parse(read_json_file(model_hash['url']))

      # TODO: does model json in the interactive json override
      # json in the model json file?
      model_hash.merge!(file_attr_hash)

      # TODO: seems that the an 'id' key in this hash sets the id
      # of the Rails model. Not sure why. This sets the model_id
      # in the InteractiveModel join to ALWAYS be 0 ??
      model_hash.delete('id')

      model_instance.json_rep = model_hash
      model_instance.gen_image_path
      model_instance.gen_new_url

      model_instance.save!
      model_instance
    end

    # def xlate_json_attrs
    #   md2d_hash['local_ref_id'] = md2d_hash.delete('id')
    # end
  end
end
