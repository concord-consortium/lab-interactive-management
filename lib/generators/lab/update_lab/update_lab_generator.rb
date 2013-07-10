module Lab
  module Generators
    class UpdateLabGenerator < Rails::Generators::Base
      # need this to pick up the USAGE file in this directory
      source_root File.expand_path('../templates', __FILE__)

      argument :tar_url, :type => :string, :default => 'http://localhost:3000'
      class_option :tar_dir, :type => :string, :default => "#{Rails.root}/tmp", :desc => "Directory that contains the lab framework archive"
      class_option :download, :type => :boolean, :default => true, :desc => "Download lab framework archive"

      def update_lab_generator
        dest_dir = "#{options['tar_dir']}/lab_files"
        FileUtils.rm_rf(dest_dir)
        FileUtils.mkdir_p(dest_dir)
        if options['download']
          puts "Lab framework archive will be downloaded to #{options['tar_dir']}"
          tarball = get_tarfile(options['tar_dir'])
        else
          tarball = "#{options['tar_dir']}/lab.tar.gz"
        end
        # tarball = "tmp/lab.tar.gz"
        puts "Unpack the tar file #{tarball} into #{dest_dir} directory"
        %x{  tar xf #{tarball}  -C #{dest_dir} }
        # name = ""

        # Gem::Package::TarReader.new(Zlib::GzipReader.open(tarball)).each do |entry|
        #   #strip root directory
        #   name = entry.full_name.split('/')[1..-1].join('/')
        #   if name && name.size > 1
        #     if entry.directory?
        #       puts "Creating directory #{name}"
        #       FileUtils.mkdir_p("#{dest_dir}/#{name}")
        #     elsif entry.file?
        #       puts "Creating file #{name}"
        #       File.open("#{dest_dir}/#{name}", 'wb') do |f|
        #         f.write(entry.read)
        #       end
        #     end
        #   end
        # end
      end

      private

      def get_tarfile(tar_dir)
        # tarball_url = 'http://github.com/concord-consortium/lab/tarball/gh-pages/'
        tarball = "#{tar_dir}/lab.tar.gz"
        puts "Download tar file from #{tar_url}"
        %x{ curl -L #{tar_url} > #{tarball} }
        puts "Saved tar file in #{tarball}"
        tarball
      end

    end
  end
end
