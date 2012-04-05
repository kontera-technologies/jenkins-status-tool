require 'rubygems'
require 'open-uri'
require 'singleton'
require 'json'

module JenkinsStatusTool
  class JenkinsBroker
    include Singleton
    
    def project_info project
      json["jobs"].select {|o| o["name"] == project}.first rescue Hash.new
    end
    
    def raw relative_path
      open("http://#{Config.instance.jenkins}/#{relative_path}").read rescue nil
    end
        
    private
    def json
      JSON.parse open("http://#{Config.instance.jenkins}/api/json").read
    end
    
  end
end
