module Lab
  module Generators
    class Md2dStoreGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      argument :source_url, :type => :string, :default => "#{Rails.root}/tmp/lab_files"
      argument :metadata_path, :type => :string, :default => '/lab/lab.json'

      def generate_store
        md2d_properties = find_md2d_meta_properties
        puts "Md2d properties defined in metadata:\n#{md2d_properties}"
        md2d_properties << ":url"
        store_str = "store :json_rep, :accessors => [" << md2d_properties.uniq.join(', ') << ']'
        opts = { :store_str => store_str}
        template("md2d_store.erb", "app/models/concerns/md2d_store.rb", opts)
      end

      private

      # Find all the properites defined for a md2d model
      def find_md2d_meta_properties
        props = []
        md2d_metadata = JSON.parse(open("#{source_url}#{metadata_path}").read)['models']['md2d']
        # Pull the hashes inside the mainProperites hash up to the top level
        metadata = md2d_metadata.delete('mainProperties')
        metadata = metadata.merge(md2d_metadata)
        metadata.each do |k, v|
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
    end
  end
end
