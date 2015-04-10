require 'sinatra'
module WinkerAI
  class HttpServer < Sinatra::Base
    
    set :port, ENV["ECHO_SERVER_PORT"] rescue raise "You must specify the server port: ECHO_SERVER_PORT=4567"
    
    WinkerAI.setup
    
    get '/command' do
      # matches "GET /hello/foo" and "GET /hello/bar"
      # params['name'] is 'foo' or 'bar'
      puts params[:q]
      WinkerAI.check_for_trigger(params[:q])
      "success"
    end
  
  end
end