require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "record_secret"
  end

  get '/' do
    if logged_in?
      @student = Student.find(session[:student_id])
    erb :index
    end
  end

  helpers do
    
    def current_student
      @current_student ||= Student.find_by(id: session[:user_id]) if session[:user_id]
  end

    def logged_in?
        !!current_student
    end

   

end
end