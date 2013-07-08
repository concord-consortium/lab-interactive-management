module Lab
  module Generators
    class InteractiveStoreGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :source_url, :type => :string, :default => Rails.public_path
      argument :metadata_path, :type => :string, :default => '/lab/lab.json'

      # TODO: check that the interactive metadata defined in lab/lab.json is the
      # same version, or short sha, that what used when creating lab framework
      # files in the public directory.
      # Need a version in the lab.json file.

      def generate_store
        begin
          interactive_properties = find_interactive_meta_properties
          store_str = "store :json_rep, :accessors => [" << interactive_properties.uniq.join(', ') << ']'
          puts "store_str:\n#{store_str}"
          opts = { :store_str => store_str}
          template("interactive_store.erb", "app/models/concerns/interactive_store.rb", opts)
        rescue SocketError, Errno::ECONNREFUSED
          puts "Can't access #{interactives_source}"
        end
      end

      private

      # Find all the properites defined for an interactive
      def find_interactive_meta_properties
        props = []
        interactive_metadata = JSON.parse(open("#{source_url}#{metadata_path}").read)['interactive']

        interactive_metadata['interactive'].each do |k, v|
          prop_name = k.to_s
          # check for illegal key names, those reserved by Rails
          if %w{ type created_at updated_at }.include?(prop_name)
            msg = "Error: Can not use a reserved name \"#{prop_name}\" for an attribute!!!"
            puts msg
          else
            props << ":#{prop_name}"
          end
        end
        props
      end

      # NOT USED YET:
      # find all the Interactive properties that are defined in the
      # interactives.json file/resource
      def find_interactives_properties(source)
        # May use this in the future to validate the the interactives defined
        # in the interactives.json has only properties defined in the interactive
        # metadata
        keys = JSON.parse(open(source).read)['interactives'].map(&:keys).uniq
        keys.flatten.map{ |k| ":#{k}"}
      end

    end
  end
end
