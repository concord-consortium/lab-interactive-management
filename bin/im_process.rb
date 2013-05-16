require 'json'

load "meta_data/interactive_metadata.rb"
#puts "interactive_meta = #{$interactive_metadata}"

# require activesupport for this?
class String
  def to_underscore!
    gsub!(/(.)([A-Z])/,'\1_\2') && downcase!
  end

  def to_underscore
    dup.tap { |s| s.to_underscore! }
  end
end

all_properties = []
model_attributes = []
serializables = []
migrations = []

# Rails Migration Types:
# :primary_key, :string, :text, :integer, :float, :decimal, :datetime, :timestamp, :time, :date, :binary, :boolean.
# m_types = {'String' => 'string', 'Array' => 'text', 'Hash' => 'text', 'Float' => 'float', 'Boolean' => 'boolean', "Fixnum" => 'integer' }

$interactive_metadata.each do |k, v|
  prop_name = k.to_s.to_underscore
  all_properties << "#{prop_name}"
  model_attributes << ":#{prop_name}"

  # if v.has_key?(:defaultValue)
  #   default = v[:defaultValue]
  #   klass_name = default.class.name

  #   # serializables << "serialize :#{prop_name}, #{klass_name}" if  %w{ Array Hash }.include?(klass_name)
  #   migration = "t.#{m_types[klass_name]}, #{prop_name}"

  #   # don't generate default for Hash and Array
  #   migration << ", :default => #{v}" unless %w{ Array Hash }.include?(klass_name)
  #   migrations << migration
  # end
end

# puts "\n model attributes"
model_attributes_str = "store :json_rep, :accessor => [" << model_attributes.join(', ') << ']'
puts model_attributes_str

#puts "\n serializable properties:"
#print serializables.join("\n")

# puts "\n migrations:"
# puts migrations.join("\n")

# puts "\n all properties method:"
# all_prop_method = <<-PMETHOD.gsub(/^ {6}/, '')
#     def all_properties
#      %w{#{all_properties.join(', ')}}
#     end
# PMETHOD
# puts all_prop_method
