module JenkinsStatusTool
  ROOT = File.expand_path File.dirname __FILE__
  
  autoload :Version, "#{ROOT}/jenkins-status-tool/version"
  autoload :WebApp,  "#{ROOT}/jenkins-status-tool/webapp"
  autoload :Runner,  "#{ROOT}/jenkins-status-tool/runner"
  autoload :Config,  "#{ROOT}/jenkins-status-tool/config"
  
  def self.version
    Version::VERSION
  end
  
end
