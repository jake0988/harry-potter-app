class StudentsController < ApplicationController

    get '/signup' do
        flash[:message]
        flash[:message] = ""
        if logged_in?
            redirect "/students/#{session[:student_id]}"
        else
            if params[:username] == ""
                flash[:message] = "Username is required"
            end
                erb :'/students/create_student'
        end
    end

    post '/students' do
        if Student.find_by(:username => params[:student][:username].downcase)
            flash[:message] = "Username already taken"
            flash[:message] 
            redirect :'/signup'
        end
        @student = Student.create(:username => params[:student][:username])
        @student.first_name = params[:student][:first]
        if @student.first_name == ""
            @student.first_name = "Unknown"
        end
        @student.last_name = params[:student][:last]
        if @student.last_name == ""
            @student.last_name = "Unknown"
        end
            @student.password = params[:password]
        if !params[:student][:house]
            flash[:message] = "Choose a House"
            flash[:message] 
            redirect '/signup'
        else
            @student.house_id = params[:student][:house].to_i
        end
        @student.save
        session[:student_id] = @student.id

        if params[:student][:username] == "Dumbledore" || params[:student][:username] == "Pomona" || params[:student][:username] == "Rowena" || params[:student][:username] == "Salazar"
            @student.update(:admin => true)
        elsif session[:student_id]
            redirect "/students/#{session[:student_id]}"
        else
            redirect "/signup"
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
            
            flash[:message] = "Incorrect Login"
        erb :'/students/login'
        end
    end

    post '/login' do
        student = Student.find_by(username: params[:student][:username])
        if student && params[:student][:username] = "Dumbledore"
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

            if @student.house_id
                @house = @student.house.name
            else
                @house = []
            end
            if @student.last_name
                @last = @student.last_name
            else
                @last = "Unknown"
            end
            
            if @student.first_name
                @first = @student.first_name
            else
                @first = "Unknown"
            end
    
            if @student.house.cup_winners.last != nil
                @cup = @student.house.cup_winners.last.year
            else
                @cup = []
            end
            erb :"/students/show"
        else
            redirect '/login'
        end
    end

    # post '/students' do
    #     if logged_in?
    #     @student = Student.find(session[:id])
        
    #     redirect "/students/show"
    #     else
    #         redirect '/login'
    #     end
    # end

    get '/students/:id/edit' do
        @student = Student.find(params[:id])
        if @student.house_id
            @house = @student.house_id
        else
            @house = []
        end

        @user = @student.username

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

        if logged_in? && session[:student_id] == @student.id || session[:student_id] == current_admin
            
            erb :'/students/edit'
        else
            redirect '/login'
        end
    end

    patch '/students/:id' do
        if logged_in?
                @student = Student.find(session[:student_id])
                @student.username = params[:student][:username]     
                @student.first_name = params[:student][:first]      
                @student.last_name = params[:student][:last]          
                @student.house_id =  params[:house].first
                @student.save
            redirect "/students/#{@student.id}"        
        else
            redirect '/login'
        end
    end

    delete '/students/:id' do
        if session[:student_id] == params[:id].to_i || current_admin
            @student = Student.find(params[:id])
            @student.delete
            session[:message] = "You have successfully deleted #{@student.username}"
            redirect '/signup'
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