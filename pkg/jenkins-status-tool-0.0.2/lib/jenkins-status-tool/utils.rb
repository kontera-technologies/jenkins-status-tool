require 'singleton'

module JenkinsStatusTool
  module Utils

    class Singleton
      include Object::Singleton
      
      def self.method_missing(m,*a,&b)
        instance.send(m,*a,&b)
      end
      
    end
    
  end
end

