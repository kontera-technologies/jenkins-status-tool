require 'rubygems'
require 'open-uri'
require 'json'

module JenkinsStatusTool
  class JenkinsBroker
    
    def project_info project
      find_job project or Hash.new
    end
    
    def raw relative_path
      open("http://#{jenkins}/#{relative_path}").read rescue nil
    end

    private
    
    def jobs
      json["jobs"] || Array.new { Hash.new }
    end

    def find_job job
      jobs.select {|o| o["name"] == job}.first
    end

    def jenkins
      Config.instance.jenkins
    end

    def json
      JSON.parse open("http://#{jenkins}/api/json").read
    end

  end
end