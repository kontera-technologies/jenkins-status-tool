require 'ostruct'
require 'singleton'

module JenkinsStatusTool
  class Config < OpenStruct
    include Singleton
    
    def initialize
      super()
      self.sinatra_root   = File.expand_path(File.join(JenkinsStatusTool::ROOT, ".."))
      self.listening_port = 7676
      self.jenkins  = "localhost"
      self.pid = '/var/run/jenkins-status-tool.pid'
    end
    
    def self.method_missing(m,*a,&b)
      instance.send(m,*a,&b)
    end
    
  end
end
