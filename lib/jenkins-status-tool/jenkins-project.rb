require 'ostruct'

module JenkinsStatusTool
  class JenkinsProject < OpenStruct

    def initialize hash
      super
      self.project = hash.fetch :project
      self.jenkins = JenkinsBroker::instance
    end
    
    def status
      case color
      when /red/     then :fail
      when /blue/    then :pass
      when /gray/    then :inactive
      else :unknown
      end
    end

    def color
      data["color"]
    end
    
    def rcov_image
      jenkins.raw rcov_path
    end
    
    private
    def rcov_path
      [job,project,rcov,graph].join "/"
    end
    
    def data
      jenkins.project_info project
    end
    
  end
end
