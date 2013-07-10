module Lab
  module Generators
    class ImportInteractivesGenerator < Rails::Generators::Base
      # need this to pick up the USAGE file in this directory
      source_root File.expand_path('../templates', __FILE__)
      argument :source_url, :type => :string, :default => "#{Rails.root}/tmp/lab_files"

      def import
        puts "Loading DB with Interactives from #{source_url}/interactives.json"
        Parser::InteractiveList.new(source_url, 'interactives.json').parse
      end
      private
    end
  end
end
