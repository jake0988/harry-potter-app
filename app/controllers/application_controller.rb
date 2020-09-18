require './config/environment'
require 'rack-flash'


class ApplicationController < Sinatra::Base
  use Rack::Flash

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
      Student.find_by(:username => "Dumbledore") if session[:admin_id] || Student.find_by(:username => "Pomona") if session[:admin_id] || Student.find_by(:username => "Rowena") if session[:admin_id] || Student.find_by(:username => "Salazar") if session[:admin_id]
    end

    def house_conversion(house_id)
      case house_id
        when 1
          return "gryffindor"
        when 2
          return "hufflepuff"
        when 3
          return "ravenclaw"
        when 4 
          return "syltherin"
        end
      end 

    end
end