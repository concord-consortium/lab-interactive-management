#!/usr/bin/env ruby

require 'json'

# assumes we in run in lab/server dir

# Looks at thru all the static interactive json files to
# determine all the interactive attributes/properties that
# are being used in at least one interactive
top_dir = 'server/public/interactives'
Dir.chdir(top_dir)
files = Dir.glob('**/*.json')
all_keys = []

# get all the keys
files.each do |f|
  i_hash = JSON.parse(File.open(f, 'r').read)
  all_keys = all_keys | i_hash.keys
end
puts "All interactive properites being used in interactive json files"
puts all_keys.join(', ')

largest = 0
files_with_largest_key_set = []
# find the files with the largest key set
files.each do |f|
  i_hash = JSON.parse(File.open(f, 'r').read)
  if (all_keys - i_hash.keys) == 0
    puts "File with *all* of the interactive keys:\n#{f}\n"
    puts i_hash_keys
    return
  end
  if i_hash.keys.size >= largest
    largest = i_hash.keys.size
  end
end


files.each do |f|
  i_hash = JSON.parse(File.open(f, 'r').read)
  if i_hash.size == largest
    files_with_largest_key_set << { f => i_hash.keys}
  end
end

puts "Files that have the largest subset of interactive keys are:\n"
files_with_largest_key_set.each do |file_hash|
  puts file_hash.zip.flatten[0]
  puts file_hash.zip.flatten[1..-1].join(', ')
end


# NOTE: some files do *not* keep the canonical ordering of interactive properties!!

# All interactive properites being used in interactive json files
# title, publicationStatus, subtitle, about, models, components, fontScale, outputs, parameters, layout, template, filteredOutputs, exports

# Files that have the largest subset of interactive keys are:
# basic-examples/output-properties-and-custom-parameters-demo.json
# title, publicationStatus, subtitle, about, fontScale, models, outputs, parameters, exports, components, layout, template
# inquiry-space/pendulum/1-pendulum.json
# title, publicationStatus, subtitle, about, fontScale, models, outputs, parameters, exports, components, layout, template
# inquiry-space/pendulum/2-spring.json
# title, publicationStatus, subtitle, about, fontScale, models, outputs, exports, parameters, components, layout, template
# inquiry-space/pendulum/3-springy-pendulum.json
# title, publicationStatus, subtitle, about, fontScale, models, outputs, parameters, exports, components, layout, template

# Ordering seems to be THIS
# title, publicationStatus, subtitle, about, fontScale, models, outputs, filteredOutputs, parameters, exports, components, layout, template
