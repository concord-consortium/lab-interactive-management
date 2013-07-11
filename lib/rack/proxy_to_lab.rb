# Proxy HTTP requests off to remote servers
class ProxyToLab < Rack::Proxy

  attr_accessor :remote_port, :remote_host, :lab_version, :lab_path_prefix

  # lab backend server settings
  include ::LabHostSettings

  def initialize(app)
    @app = app
    setup_lab_server
  end

  def call(env)
    original_host = env["HTTP_HOST"]

    # Rewrite HTTP URL if we should forward request
    # to a remote server.
    rewrite_env(env)

    if env["HTTP_HOST"] != original_host
      # do remote request
      # TODO: add better error, timeout handling
      perform_request(env)
    else
      # no remote request
      # just forward to next middleware
      @app.call(env)
    end
  end

  # Set the remote host, port and path for
  # matching URIs
  def rewrite_env(env)
    request = Rack::Request.new(env)

    if request.path =~ %r{^\/imports\/.*}
      # example of a remote host with a lab framework version
      # http://lab.dev.concord.org/version/2666763/

      # set the remote host
      env['HTTP_HOST'] = "#{remote_host}:#{remote_port}"
      # set the remote path
      env['PATH_INFO'] = "/#{lab_path_prefix}/#{lab_version}#{env['PATH_INFO']}"

    end
    env
  end

end
