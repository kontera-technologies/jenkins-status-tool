module JenkinsStatusTool
  class JenkinsProject

    attr_reader :project, :jenkins

    def initialize hash
      @project = hash.fetch :project
      @jenkins = JenkinsBroker.new
    end
    
    def status
      case color
      when :red  then :fail
      when :blue then :pass
      when :gray then :inactive
      else :unknown
      end
    end

    def color
      case data["color"]
      when /red/  then :red
      when /blue/ then :blue
      when /gray/ then :gray
      else nil
      end
    end
    
    def rcov_image
      jenkins.raw rcov_path
    end
    
    private
    def rcov_path
      ["job",project,"rcov","graph"].join "/"
    end
    
    def data
      jenkins.project_info project
    end
    
  end
end
