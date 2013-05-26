module Lab
  module Generators
    class UpdateLabGenerator < Rails::Generators::Base
      # source_root File.expand_path('../templates', __FILE__)
      argument :tar_url, :type => :string, :default => 'http://localhost:3000'
      # class_option :tar_url, :type => :string, :default => 'http://localhost:3000', :desc => "URL for the tar file"

      # https://lab-staging.s3.amazonaws.com/lab_ab633d2.tar.gz
      desc "update_from_tar"
      def update_from_tar
        # puts "tar_url = #{tar_url}"
        # puts "options = #{options}"
        tmp_dir = "#{Rails.root}/tmp"
        dest_dir = Rails.public_path
        FileUtils.mkdir_p(tmp_dir)

        tarball = get_tarfile(tmp_dir)
        # tarball = "tmp/lab.tar.gz"
        puts "Unpack the tar file into #{dest_dir} directory"
        %x{  tar xf #{ tarball}  -C #{Rails.public_path} }
        name = ""

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

      def get_tarfile(tmp_dir)
        # tarball_url = 'http://github.com/concord-consortium/lab/tarball/gh-pages/'
        tarball = "#{tmp_dir}/lab.tar.gz"
        puts "Download tar file from #{tar_url}"
        %x{ curl -L #{tar_url} > #{tarball} }
        puts "Saved tar file in #{tarball}"
        tarball
      end
    end
  end
end
