require 'sinatra/base'

module JenkinsStatusTool
  class WebApp < Sinatra::Base
    
    set :root, Config.sinatra_root
    set :port, Config.listening_port
    
    get "/" do
      erb :index
    end
    
  end
end