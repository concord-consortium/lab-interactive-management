module Parser
  class Md2d < Base
    attr_reader :md2d_hash

    def initialize(url, md2d_hash = {})
      super(url)
      # md2d_hash contains json defined in a specific interactive json file
      # for this model. Note: part of the model is defined in the interactive
      # json file and the other part, most, is defined in a json for this md2d
      # model
      @md2d_hash = md2d_hash.dup
    end

    def create_model
      # TODO: get the revision for the md2d from json
      md2d = ::Md2d.new(:revision => '0.0.1', :from_import => true)

      # read the contents of one md2d json file
      puts "Reading Md2d JSON from #{uri}/#{md2d_hash['url']}"
      file_attr_hash = JSON.parse(read_json_file(md2d_hash['url']))

      # TODO: does md2d json in the interactive json override
      # json in the md2d json file?
      md2d_hash.merge!(file_attr_hash)

      # TODO: seems that the an 'id' key in this hash sets the id
      # of the Md2d Rails model, md2d. Not sure why. This sets the model_id
      # in the InteractiveModel join to ALWAYS be 0 ??
      md2d_hash.delete('id')
      md2d.json_rep = md2d_hash
      md2d.gen_new_url

      md2d.save!
      md2d
    end

    # def xlate_json_attrs
    #   md2d_hash['local_ref_id'] = md2d_hash.delete('id')
    # end
  end
end
