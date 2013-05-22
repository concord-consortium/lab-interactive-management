class Md2dStoreGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

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
    load_metadata
    # pull the hashes inside the mainProperites hash up to the top level
    main_properties = $md2d_metadata.delete(:mainProperties)
    metadata = $md2d_metadata.merge(main_properties)

    metadata.each do |k, v|
      prop_name = k.to_s
      if %w{ type created_at updated_at }.include?(prop_name)
        msg = "Error: Can not use a reserved name \"#{prop_name}\" for an attribute!!!"
        puts msg
        # prop_name = "_#{prop_name}"
        # puts "Changed attribute name to #{prop_name}"
      else
        props << ":#{prop_name}"
      end
    end
    props
  end

  def load_metadata
    # TODO: get this from the lab web server?
    # $md2d_metadata = JSON.parse(open("#{source_url}/md2d_metadata.rb"))

    # make sure that this file reflects the latest md2d meta data
    # md2d metadata is defined in that lab project at:
    # src/lab//md2d/models/metadata.js
    load "#{Rails.root}/meta_data/md2d_metadata.rb"
  end

end
