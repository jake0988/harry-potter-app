class StudentsController < ApplicationController
    # get '/students/:slug' do
    #     @student = Student.find_by_slug(params[:slug])
    #     erb :'/students/show'
    # end

    get '/signup' do
        if logged_in?
            redirect "/students/#{session[:student_id]}"
        else
            erb :'/students/create_student'
        end
    end

    post '/students' do
        @student = Student.create(:username => params[:username])
        @student.first_name = params[:name][:last]
        @student.last_name = params[:name][:first]
        @student.password = params[:password]
        @student.house_id = params[:house][:number]
        @student.save
        if params[:username] = "Dumbledore"
            session[:admin_id] = @student.id
        end
        if @student.id
            redirect "/students/#{@student.id}"
        else
            redirect "/"
        end
    end

    get '/login' do
        if logged_in?
            @student = Student.find(session[:student_id])
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
            redirect "students/#{@student.id}"
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
        erb :'/login'
        else
            redirect "/"
        end
    end

end