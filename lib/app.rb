require 'sinatra'
require 'slim'
require "sinatra/reloader" if development?

class AgileCircleApp < Sinatra::Base
  enable  :sessions, :logging
  configure :development do
    register Sinatra::Reloader
  end
  helpers do
    def protected!
      unless authorized?
        response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
        throw(:halt, [401, "Not authorized\n"])
      end
    end

    def authorized?
      @auth ||=  Rack::Auth::Basic::Request.new(request.env)
      @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == ['admin', 'admin']
    end
  end

  get '/' do
    slim :index
  end

  get '/protected' do
    protected!
    "Welcome authenticated client"
  end
  
  get '/test' do
    session['counter'] ||= 0
    session['counter'] += 1
    "You've hit this page #{session['counter']} times!"
  end
  
  get '/hello' do
    if params[:name]
      "Hello #{params[:name]}" 
    else
      "Hello World"
    end
  end
end