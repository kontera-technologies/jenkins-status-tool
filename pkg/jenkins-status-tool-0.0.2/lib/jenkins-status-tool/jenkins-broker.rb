require 'rubygems'
require 'open-uri'
require 'singleton'
require 'json'

module JenkinsStatusTool
  class JenkinsBroker < JenkinsStatusTool::Utils::Singleton
    
    def status(hash)
      case project_info(hash[:project])["color"]
      when "blue" then
        :pass
      when "gray" then
        :inactive
      when "red" then
        :fail
      else
        :unknown
      end
    end
    
    private
    def project_info(project)
      api["jobs"].select {|o| o["name"] == project}.first rescue Hash.new
    end
    
    def api
      JSON.parse open("http://#{config.jenkins}/api/json").read
    end
    
    def config
      Config.instance
    end
    
  end
end
