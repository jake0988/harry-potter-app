class StudentsController < ApplicationController
    get '/students/:slug' do
        @student = Student.find_by_slug(params[:slug])
        erb :'/students/show'
    end

    get '/signup' do
        if logged_in?
            @id = session[:student_id]
            redirect "/student/#{@id}"
        else
            erb :'/students/create_student'
        end
    end

    post '/students' do
        @student = Student.new(:name => params[name])
        @student.house_id = params[:house]
        @student.save

        redirect "/students/#{@student.id}"
    end

    get '/students/login' do
        if logged_in?
            redirect '/students/show'
        else
        erb '/students/login'
        end
    end

    post '/students/login' do
        if logged_in?
            @student = session[:id]
            session[:student_id] = @student.id
            redirect "students/#{@student.id}"
        else
            redirect '/login'
        end
    end

    get '/students/:id' do
        if logged_in?
            @student = Student.find(params[:id])
                erb :"/students/#{@student.id}"
        else
            redirect '/students/login'
        end
    end

    post '/students/:id' do
        if logged_in?
        student = Student.find(session[:id])
        redirect "/students/show"
        else
            redirect '/login'
        end
    end

    delete '/students/:id/delete' do
        if session[student_id] == 1
            @student = Student.find(params[:id])
            @student.delete
        else
            redirect '/login'
        end
    end

end