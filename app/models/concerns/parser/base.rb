require 'open-uri'

module Parser
  class ParsingError < StandardError; end;
  class Base

    attr_accessor :uri, :path

    def initialize(uri)
      self.uri = uri
      # URI.scheme_list.values.map(&:to_s).map{ |s| s.split('::').last.downcase }
      # schemes = URI.scheme_list.values.map(&:to_s)
      # self.uri = case uri.class.name
      #            when 'String'

      #            when schemes.include?(uri.class.name)
      #              uri
      #            else
      #              raise ArgumentError, "uri must be a String or a an instance of #{schemes.join(', ')}"
      #            end
    end

    def read_json_file(path)
      location = "#{self.uri}/#{path}"
      full_url = uri.match(/^http::/) ? URI.parse(location) : location
      open(full_url).read
    end
  end
end
