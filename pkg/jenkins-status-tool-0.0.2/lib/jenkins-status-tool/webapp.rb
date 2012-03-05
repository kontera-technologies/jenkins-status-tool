require 'sinatra/base'

module JenkinsStatusTool
  class WebApp < Sinatra::Base
    
    set :root, root
    set :port, Config.instance.port
    
    get "/" do
      erb :index
    end
    
    get "/project/:project/status.?:format?" do
      status = JenkinsBroker.status(:project => params[:project])
      
      case params[:format]
      when /png|gif/
        redirect "/images/#{status}.png"
      when /json/
        {:status => status }.to_json
      else
        raise ArgumentError.new "#{params[:format]} is not supported yet..."
      end
    end
    
    private
    def self.root
      File.expand_path File.join(JenkinsStatusTool::ROOT, "..")
    end
    
  end
end