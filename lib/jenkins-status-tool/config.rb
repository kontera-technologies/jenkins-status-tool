require 'singleton'

module JenkinsStatusTool
  class Config

    include Singleton

    attr_reader :options
    
    def initialize
      @options = Utils.default_options
    end
    
    def https?
      options[:https]
    end

    def method_missing(m, *a, &b)
      options.fetch(m) rescue options.send(m,*a,&b)
    end
    
  end
end