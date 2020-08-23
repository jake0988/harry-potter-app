class StudentsController < ActiveRecord
    get '/students' do
        @students = Student.all
        erb :'/login'
    end

    get '/students/new' do
        if is_logged_in?
        @student = Student.find(params[session][user_id]) 
        erb :'/student/create_student'
        else
            redirect '/login'
        end
    end
    end