class FavoritesController < ApplicationController
    get '/favorites' do
        flash[:message]
        if Favorite.nil?
            flash[:message] = "Be the first to enter a favorite person!"
            flash[:message]
            redirect '/favorites/new'
        else
            @favorites = Favorite.all
            erb :'/favorites/favorites'
        end
    end

    get '/favorites/new' do
        if logged_in?
            erb :'/favorites/create_favorite'
        else
            flash[:message] = "Please login"
            flash[:message]
            redirect '/login'
        end
    end

    post '/favorites' do
        if logged_in?
            if params[:comment] == ""
                redirect '/favorites/new'
            else
                @favorite = current_student.favorites.create(person: params[:student][:person], comment: params[:student][:comment])
                if @favorite.save
                    redirect "/favorites/#{@favorite.id}"
                else
                    redirect '/favorites/new'
                end
            end
        else
            redirect '/login'
        end
    end

    get '/favorites/me' do
        if logged_in?
            @student = session[:student_id]
            @favorites = Favorite.where(student_id: @student)
            erb :'/favorites/my_favorites'
        else
            redirect '/login'
        end
    end


    get '/favorites/:id' do
        flash[:message]
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if @favorite && @favorite.student_id == current_student.id 
                @student = Student.find(session[:student_id])
                @person = @favorite.person
                @comment = @favorite.comment
                erb :'/favorites/show_favorite'
            else
                redirect '/favorites'
            end
        else
            redirect '/login'
        end
    end

    get '/favorites/:id/edit' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if @favorite && @favorite.student_id == current_student.id
                erb :'/favorites/edit_favorite'
            else
                redirect '/favorites'
            end
        else
            redirect '/login'
        end
    end 

    patch '/favorites/:id' do
        if logged_in?
            
            @person = params[:student][:person]
            if @person == ""
                flash[:message] = "Please enter favorite person's name"
                flash[:message]
                redirect "/favorites"
            else
                
                @comment = params[:student][:comment]
                @favorite = Favorite.find(params[:id])
                @favorite.update(person: @person, comment: @comment)
                if @favorite && @favorite.student_id == current_student.id
                    
                    
                    redirect "/favorites/#{@favorite.id}"
                else
                    flash[:message] = "Can only edit your own favorite people"
                    flash[:message]
                    redirect "/favorites/#{@favorite.id}/edit" 
                end
            end
            
        else
            redirect '/login'
        end
    end

    delete '/favorites/:id/delete' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if @favorite && @favorite.student_id == current_student.id
                @favorite.delete
            end
        redirect '/favorites'
        else
            redirect '/login'
        end
    end

end
