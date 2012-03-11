require 'sinatra/base'

module JenkinsStatusTool
  class WebApp < Sinatra::Base
        
    def self.config; Config.instance end
    def config; self.class.config end
    
    set :root, config.root
    set :port, config.port
    
    get "/" do
      erb :index
    end
    
    get "/project/:project/status.?:format?" do
      case format
      when :png  then
         redirect "/images/#{project.status}.png"
      when :json then
         {:status => project.status }.to_json
      end
    end
    
    get "/project/:project/rcov.?:format?" do
      case format
      when :png then
        content_type 'image/jpeg'
        project.rcov_image or redirect "/images/rcov-no-data.png"
      end
    end
    
    protected
    def redirect path
      if config.https? and relative? path
        super "https://#{request.host}#{path}" 
      else
        super path
      end
    end
    
    def relative? path
      path !~ /http(s*)?:\/\//
    end
    
    def format
      symbolize_params.fetch(:format).to_sym
    end
    
    def symbolize_params
      @_params ||= Hash[params.map {|a| [a[0].to_sym,a[1]]}]
    end
    
    def project
      @project ||= JenkinsProject.new symbolize_params
    end
        
  end
end