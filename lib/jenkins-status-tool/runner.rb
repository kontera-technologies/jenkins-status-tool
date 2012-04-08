require 'optparse'

module JenkinsStatusTool
  class Runner

    def initialize(argv)
      parser.parse! argv
    end
    
    def run!
      config.daemonize ? daemonize! : WebApp.run!
    end
    
    private
    def daemonize!
      fork do
        Process.setsid
        exit if fork
        Dir.chdir('/tmp')
        STDOUT.reopen('/dev/null','a')
        STDIN.reopen('/dev/null')
        STDERR.reopen('/dev/null','a')
        File.open(options.pid, 'w') { |f| f.write Process.pid } rescue nil
        WebApp.run!
      end
    end
        
    def parser
      OptionParser.new do |opts|
        opts.banner = "The Jenkins Status Tool"
        opts.define_head "Usage: jenkins-status-tool [options]"
        opts.separator ""
        opts.separator "Options:"
        
        opts.on('-j', '--jenkins URL', 'Jenkins url, e.g http://jenkins:8080, default is localhost') do |url|
          config[:jenkins] = url
        end
        
        opts.on('-p', '--port URL', 'listening port, default is 7676') do |port|
          config[:port] = port
        end
        
        opts.on("-d", "--daemonize","run in background") do
          config[:daemonize] = true
        end
        
        opts.on("-P", "--pid-file FILE","pid file, default /var/run/jenkins-status-tool.pid") do |file|
          config[:pid] = file
        end
        
        opts.on('-s', '--https', 'add this switch if you are running behind https forwarder (e.g stunnel)') do
          config[:https] = true
        end
        
        opts.separator ""
        opts.separator "More Info:"
        opts.separator "https://github.com/kontera-technologies/jenkins-status-tool"
        opts.separator ""
      end
    end
    
    def config
      Config.instance
    end
    
  end
end