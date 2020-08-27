require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "abacadabra"
  end

  get '/' do
    if logged_in?
      @student = Student.find(session[:student_id])
    end
    erb :index
  end

  helpers do
    
    def logged_in?
      !!current_student
    end

    def current_student
      @current_student ||= Student.find_by(id: session[:student_id]) if session[:student_id]
    end

    def admin_logged_in?
      !!current_admin
    end
 
    def current_admin
      binding.pry
      @current_student ||= Student.find_by(:username => "Dumbledore") if session[:admin_id]
    end

    end
end