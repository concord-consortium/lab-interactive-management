namespace :app do

  JRUBY = defined?(RUBY_ENGINE) && RUBY_ENGINE == 'jruby'

  def ruby_system_command
    JRUBY ? "jruby -S" : ""
  end

  def ruby_run_command
    JRUBY ? "jruby " : "ruby "
  end

  def ruby_run_server_command
    jruby_run_command + (JRUBY ? "-J-server " : "")
  end

  namespace :import do
    desc "import interactives from public/interactives.json"
    task :built_interactives => ['db:reset'] do
      Parser::InteractiveList.new('http://localhost:3000', 'interactives.json').parse
    end
  end
end
