require 'ostruct'
require 'singleton'

module JenkinsStatusTool
  class Config < OpenStruct
    include Singleton
    
    def initialize
      super
      self.port    = 7676
      self.jenkins = "localhost:8080"
      self.pid     = '/var/run/jenkins-status-tool.pid'
      self.root    = File.expand_path File.join(JenkinsStatusTool::ROOT, "..")
      self.https   = false
    end
    
    def https?
      self.https
    end
    
  end
end
