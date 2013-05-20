class InteractiveStoreGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)
  argument :source_url, :type => :string, :default => 'http://localhost:3000'

  def generate_store
    begin
      interactives_source = "#{source_url}/interactives.json"
      interactive_properties1 = find_interactives_properties(interactives_source)
      #puts "Interactive properties defined in #{interactives_source}\n#{interactive_properties1.inspect}"
      # [:title, :path, :groupKey, :subtitle, :about, :publicationStatus]

      interactive_properties = find_interactive_meta_properties
      # puts "Interactive properties defined in metadata:\n#{interactive_properties}"

      interactive_properties.concat(interactive_properties1)
      store_str = "store :json_rep, :accessors => [" << interactive_properties.uniq.join(', ') << ']'
      puts "store_str:\n#{store_str}"
      opts = { :store_str => store_str}
      template("interactive_store.erb", "app/models/concerns/interactive_store.rb", opts)
    rescue SocketError, Errno::ECONNREFUSED
      puts "Can't access #{interactives_source}"
    end
  end

  private

  # find all the Interactive properties that are defined in the
  # interactives.json file/resource
  def find_interactives_properties(source)
    # TODO: may replace this with a static list of properties if they
    # don't change
    # Interactive properties that are defined in the interactives.json file
    keys = JSON.parse(open(source).read)['interactives'].map(&:keys).uniq
    keys.flatten.map{ |k| ":#{k}"}
  end

  # Find all the properites defined for an interactive
  def find_interactive_meta_properties
    props = []
    load_metadata
    $interactive_metadata.each do |k, v|
      prop_name = k.to_s
      if %w{ type created_at updated_at }.include?(prop_name)
        msg = "Error: Can not use a reserved name \"#{prop_name}\" for an attribute!!!"
        puts msg
      else
        props << ":#{prop_name}"
      end
    end
    props
  end

  def load_metadata
    # TODO: get this from the lab web server?
    # $interactive_metadata = JSON.parse(open("#{source_url}/interactive_metadata.rb"))

    # For now, make sure that this file reflects the latest interactive meta data
    # interactive metadata is defined in that lab project at:
    # src/lab/common/controllers/interactive-metadata.js
    load "#{Rails.root}/meta_data/interactive_metadata.rb"
  end

end
