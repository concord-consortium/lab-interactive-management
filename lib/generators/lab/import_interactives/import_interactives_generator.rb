module Lab
  module Generators
    class ImportInteractivesGenerator < Rails::Generators::Base
      argument :source_url, :type => :string, :default => 'http://localhost:3000'

      def import
        puts "Loading DB with Interactives from #{source_url}/interactives.json"
        Parser::InteractiveList.new(source_url, 'interactives.json').parse
      end
      private
    end
  end
end
