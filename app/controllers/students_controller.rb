class StudentsController < ApplicationController
    # get '/students/:slug' do
    #     @student = Student.find_by_slug(params[:slug])
    #     erb :'/students/show'
    # end

    get '/signup' do
        if logged_in?
            redirect "/students/#{session[:student_id]}"
        else
            if session[:error]
                @error = session[:error]
            end
            erb :'/students/create_student'
        end
    end

    post '/students' do
        @student = Student.create(:username => params[:student][:username])
        @student.first_name = params[:student][:first]
        @student.last_name = params[:student][:last]
        @student.password = params[:student][:password]
        if params[:student][:house]
        @student.house_id = params[:student][:house].first.to_i
        end
        @student.save
        if params[:student][:username] == "Dumbledore" && @student_id
            session[:admin_id] == @student.id
        end
        if @student.errors.messages
            # session[:error] = @student.errors.messages
            flash[:message] = @student.errors.messages
            redirect '/signup'
      
        elsif @student.id
            redirect "/students/#{@student.id}"
        else
            redirect "/"
        end
    end

    get '/login' do
        if logged_in?
            @student = Student.find(session[:student_id])
            if admin_logged_in?
            @house = House.all
            end
            redirect '/students/show'
        else
        erb :'/students/login'
        end
    end

    post '/login' do
        
        student = Student.find_by(username: params[:username])
        if params[:username] = "Dumbledore"
            session[:admin_id] = student.id
        end
        if student && student.authenticate(params[:password])
            session[:student_id] = student.id
            redirect "students/#{student.id}"
        else
            redirect '/login'
        end
    end

    get '/students/:id' do
        if logged_in?
            @student = Student.find(session[:student_id])  
    
            erb :"/students/show"
        else
            redirect '/login'
        end
    end

    post '/students/:id' do
        if logged_in?
        @student = Student.find(session[:id])
        redirect "/students/show"
        else
            redirect '/login'
        end
    end

    get '/students/:id/edit' do
        @student = Student.find(params[:id])
        if @student.house_id
            @house = @student.house_id
        else
            @house = []
        end
        if @student.last_name
            @last = @student.last_name
        else
            @last = []
        end
        
        if @student.first_name
            @first = @student.first_name
        else
            @first = []
        end

        if @student.cup_winners.last != nil
            @cup = @student.cup_winners.last.year
        else
            @cup = []
        end

        if logged_in? && session[:student_id] == @student.id || current_admin
            erb :"/students/edit_student"
        else
            redirect '/login'
        end
    end

    delete '/students/:id/delete' do
        if session[student_id] == params[:id] || current_admin
            @student = Student.find(params[:id])
            @student.delete
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.destroy
        erb :'students/login'
        else
            redirect "/"
        end
    end

    get '/delete' do
        Student.delete_all
        redirect '/'
    end

end