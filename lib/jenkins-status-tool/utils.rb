module JenkinsStatusTool
  module Utils
    module_function

    def default_options
      {
        :port    => 7676,
        :jenkins => "localhost:8080",
        :pid     => '/tmp/jenkins-status-tool.pid',
        :root    => File.expand_path("../../..",__FILE__),
        :https   => false,
        :daemonize => false
      }
    end
    
  end
end