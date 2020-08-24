class StudentsController < ApplicationController
    get '/students/:slug' do
        @student = Student.find_by_slug(params[:slug])
        erb :'/students/show'
    end

    get '/signup' do
        if is_logged_in?
            @id = session[:student_id]
            redirect "/student/#{@id}"
        else
            erb :'/student/create_student'
        end
    end

    post '/signup' do
        @student = Student.new(:name => params[name])
        @student.house_id = params[:house]
        @student.save

        redirect "/students/#{@student.id}"
    end

    get '/students/new' do
        if is_logged_in?
        @student = Student.find(params[session][user_id]) 
        erb :'/student/create_student'
        else
            redirect '/login'
        end
    end

    post '/students/:id' do
        student = Student.find(session[:id])
        redirect "/students/#{student.id}"
    end
end