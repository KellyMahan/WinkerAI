require 'sinatra'
module WinkerAI
  class HttpServer < Sinatra::Base
    
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