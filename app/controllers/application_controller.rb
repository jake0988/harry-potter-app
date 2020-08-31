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
      @current_student ||= Student.find_by(:username => "Dumbledore") if session[:admin_id]
    end

    def house_conversion(house_id)
      case house_id
        when "Gryffendore"
          return 1
        when "Hufflepuff"
          return 2
        when "Ravenclaw"
          return 3
        when "Syltherin"
          return 4
        end
      end 

    end
end