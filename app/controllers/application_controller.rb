require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "record_secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    
    def logged_in?
        !!current_owner
    end

    def current_user
        @current_owner ||= Owner.find_by(id: session[:user_id]) if session[:user_id]
    end

    end
end