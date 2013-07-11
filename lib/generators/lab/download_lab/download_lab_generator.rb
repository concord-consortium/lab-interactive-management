module Lab
  module Generators
    class DownloadLabGenerator < Rails::Generators::Base
      # need this to pick up the USAGE file in this directory
      source_root File.expand_path('../templates', __FILE__)

      argument :tar_url, :type => :string, :default => 'http://localhost:3000'
      class_option :tar_dir, :type => :string, :default => "#{Rails.root}/tmp", :desc => "Directory that contains the lab framework archive"
      class_option :download, :type => :boolean, :default => true, :desc => "Download lab framework archive"

      def download_lab_generator
        dest_dir = "#{options['tar_dir']}/lab_files"
        FileUtils.rm_rf(dest_dir)
        FileUtils.mkdir_p(dest_dir)
        if options['download']
          puts "Lab framework archive will be downloaded to #{options['tar_dir']}"
          tarball = get_tarfile(options['tar_dir'])
          puts "Generating the settings to proxy to the backend lab server"
          generate_lab_settings(tar_url)
        else
          tarball = "#{options['tar_dir']}/lab.tar.gz"
        end

        # tarball = "tmp/lab.tar.gz"
        puts "Unpack the tar file \n\t#{tarball}\n\t into\n\t#{dest_dir} directory"
        %x{  tar xf #{tarball}  -C #{dest_dir} }
        # Bad tar file, bye
        exit(false) unless $?.success?


        # cd to dir containing downloaded files, tmp/lab_files
        Dir.chdir(dest_dir)

        # TODO: may not need all of these, or may may web app specific version of these
        # copy the lab top level html and css files
        # NOTE: don't cp application.js
        Dir.glob("*.{html,css}") do |filename|
          puts "Copying lab file:\n\t #{dest_dir}/#{filename} into the public directory"
          FileUtils.cp("#{dest_dir}/#{filename}", Rails.public_path)
        end

        # copy the lab directories
        %w{ lab resources vendor }.each do |dir|
          puts "Copying lab directory:\n\t#{dest_dir}/#{dir} into the public directory"
          FileUtils.cp_r("#{dest_dir}/#{dir}", Rails.public_path)
        end

      end

      private

      # Generate the file that define the remote lab server
      # This file is used by the Lab Proxy class
      def generate_lab_settings(tar_url)
        # typical lab server URL
        # http://lab.dev.concord.org/version/2666763.tar.gz')
        uri = URI.parse(tar_url)
        lab_settings = {:host => uri.host, :port => uri.port }
        # version in above url
        lab_settings[:path_prefix] = uri.path.split('/')[1]
        # lab release version of git short SHA, 2666763
        lab_settings[:release_number] = uri.path.split('/')[2].split('.')[0]
        template("lab_host_settings.erb", "lib/rack/lab_host_settings.rb", lab_settings)
      end

      def get_tarfile(tar_dir)
        tarball = "#{tar_dir}/lab.tar.gz"
        FileUtils.rm_rf(tarball)
        puts "Download tar file from #{tar_url}"
        %x{ curl -L #{tar_url} > #{tarball} }
        puts "Saved tar file in #{tarball}"
        tarball
      end

    end
  end
end
