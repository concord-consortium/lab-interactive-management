module Parser
  class InteractiveList < Base

    attr_reader :interactives, :groups

    def initialize(url, path="")
      super(url)
      interactives = self.read_json_file(path)
      all = JSON.parse(interactives)
      @interactives = all['interactives']
      @groups = all['groups']
    end

    def parse
      groups.each do |group_hash|
        Parser::Group.new(group_hash).create_model
      end
      interactives.each do |interactive_hash|
      # pass an interactive definition/hash defined in the interactives.json
      # file
        begin
          parser =  Parser::Interactive.new(self.uri, interactive_hash)
          parser.create_model()
        rescue OpenURI::HTTPError => e
          puts "WARNING: #{e.message}"
        rescue Exception => e
          puts "Error: reading JSON file #{interactive_hash['path']}"
          #raise e
        end
      end
    end

  end
end
