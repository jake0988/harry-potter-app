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
        @student = Student.create(:username => params[:username])
        @student.first_name = params[:name][:last]
        @student.last_name = params[:name][:first]
        @student.password = params[:password]
        num = house_conversion(params[:house][:number])
        @student.house_id = num
        @student.save

        if !@student.valid?
            # session[:error] = @student.errors.messages
            # binding.pry
            @student.reload
            binding.pry
            redirect '/signup'
        elsif params[:username] == "Dumbledore"
            binding.pry
            session[:admin_id] == @student.id
        elsif @student.id
            binding.pry
            redirect "/students/#{@student.id}"
        else
            binding.pr
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
            # binding.pry
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
        if session[student_id] = @student.id
            erb :"/students/#{@student.id}"
        else
            redirect '/students/'
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

end