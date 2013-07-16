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
      interactive = ::Interactive.new(:revision => '0.0.1',:from_import => true, :group_key => interactive_hash['groupKey'])

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
          create_model_type(model_hash, interactive)
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

    def create_model_type(model_hash, interactive)
      # Parser of all of the model types
      p = Parser::Model.new(self.uri, model_hash)

      case model_hash['type']
      when 'energy2d'
        energy_model = ::Energy2d.new(:revision => '0.0.1', :from_import => true)
        p.create_model(energy_model)
        interactive.energy2ds << energy_model
      when 'md2d'
        md2d_model = ::Md2d.new(:revision => '0.0.1', :from_import => true)
        p.create_model(md2d_model)
        interactive.md2ds << md2d_model
      when 'sensor'
        sensor_model = ::Sensor.new(:revision => '0.0.1', :from_import => true)
        p.create_model(sensor_model)
        interactive.sensors << sensor_model
      when 'signal-generator'
        sg_model = ::SignalGenerator.new(:revision => '0.0.1', :from_import => true)
        p.create_model(sg_model)
        interactive.signal_generators << sg_model
      when 'solar-system'
        solar_model = ::SolarSystem.new(:revision => '0.0.1', :from_import => true)
        p.create_model(solar_model)
        interactive.solar_systems << solar_model
      end
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
