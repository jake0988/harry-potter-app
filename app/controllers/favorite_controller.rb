class FavoriteController < ApplicationController
    get '/favorites' do
        @favorite = Favorite.all
        erb :'/favorites/favorites'
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
            if params[:content] == ""
                redirect '/favorites/new'
            else
                @favorite = current_student.favorites.build(person: params[:student][:person], content: params[:student][:content])
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

    get '/favorites/:id' do
        if logged_in?
            @student = Student.find(params[:id])
            @favorites = @student.favorites
          erb :'/favorites/show_favorite'
        else
            redirect '/favorites/login'
        end
    end

    get '/favorites/:id/edit' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if @favorite && @favorite.id == current_student
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
            if @person == ""
                flash[:message] = "Please enter person's name"
                flash[:message]
                redirect "/favorites/#{@favorite.id}/edit"
            else
                    @favorite = Favorite.find(params[:id])
                if @favorite && @favorite.id == current_student
                    @person = params[:student][:person]
                    @comment = params[:student][:comment]
                    @favorite.update(person: @person, comment: @comment)
                else
                    redirect "/favorites/#{favorite.id}/edit" 
                end
            
            redirect "/favorites/#{@favorite.id}"
            else
                redirect '/login'
        
    end

    delete '/favorites/:id/delete' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if @favorite && @favorite.id == current_student
                @favorite.delete
            end
        redirect '/favorites'
        else
            redirect '/login'
        end
    end

end
