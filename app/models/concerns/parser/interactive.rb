module Parser
  class Interactive < Base

    attr_reader :interactive_hash

    def initialize(url, interactive_hash = {})
      super(url)
      # interactive_hash contains json defined in the interactives.json file
      # for a specific interactive
      @interactive_hash = interactive_hash
    end

    # create the Interactive Rails model
    def create_model
      # TODO: get the revision from the interactive JSON file
      interactive = ::Interactive.new(:revision => '0.0.1',:from_import => true)

      # read the contents of one interactive json file
      puts "Reading Interactive JSON from #{uri}/#{interactive_hash['path']}"
      file_attr_hash = JSON.parse(read_json_file(interactive_hash['path']))

      # TODO: does interactive json in interactives.json override
      # json in the interactive json file?
      interactive_hash.merge!(file_attr_hash)

      interactive.json_rep = interactive_hash

      group = ::Group.find_by_path(interactive_hash['groupKey'])
      interactive.group = group

      # generate the path that will identify this interactive outside this app
      interactive.gen_new_path

      interactive.json_rep['models'].each do |model_hash|
        begin
          p = Md2d.new(self.uri, model_hash)
          md2d_model = p.create_model
          interactive.md2ds << md2d_model
        rescue OpenURI::HTTPError => e
          # problem getting the interactive json file via HTTP
          puts "WARNING: #{e.message}"
        rescue Exception => e
          puts "Error: reading JSON file #{model_hash['url']}" #  : #{e}"
          # lets keep going
          # raise e
        end
      end

      interactive.gen_new_model_paths
      interactive.save!
      interactive
    end

    def  xlate_file_attrs(interactive, file_attr_hash)
      # # taken from interactive meta data, all but the interactive model
      # ["title", "publicationStatus", "subtitle", "about",  "components", "fontScale", "outputs", "parameters", "layout", "template", "filteredOutputs", "exports"].each do |prop|
      #   interactive.send("#{prop.underscore}=", file_attr_hash[prop]) if file_attr_hash.has_key?(prop)
      # end
      # # 'models'
    end

    # TODO: replace about assignment with this method
    def xlat_about(about)
      case about.class
      when Array
        about.join(' ')
      when String
        about
      else
        raise ArgumentError.new("about field is the wrong type!")
      end
    end
  end
end
