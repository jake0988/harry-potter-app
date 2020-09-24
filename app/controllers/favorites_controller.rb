class FavoritesController < ApplicationController
    
    get '/favorites' do
        if Favorite.nil?
            flash[:message] = "Be the first to enter a favorite band!"

            redirect '/favorites/new'
        else
            @favorites = Favorite.all
            erb :'/favorites/index'
        end
    end

    get '/favorites/new' do
        if logged_in?
            erb :'/favorites/create_favorite'
        else
            flash[:error] = "Please login"
            redirect '/login'
        end
    end

    post '/favorites' do
        if logged_in?
            #  if params[:comment] == ""
            #     flash[:error] = ""
            #     redirect '/favorites/new'
            # else
                favorite = current_student.favorites.create(band: params[:band], comment: params[:comment], band_url: params[:band_url])
                if favorite.save
                    redirect "/favorites/#{favorite.id}"
                else
                    flash[:error] = "Favorites creation failed: #{favorite.errors.full_messages.to_sentence}"
                    redirect '/favorites/new'
                end
           
        else
            flash[:error] = "Please login."
            redirect '/login'
        end
    end

    get '/favorites/me' do
        if logged_in?
            @student = session[:student_id]
            @favorites = Favorite.where(student_id: @student)
            erb :'/favorites/my_favorites'
        else
            flash[:error] = "Please login"
            redirect '/login'
        end
    end


    get '/favorites/:id' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if authorized_to_edit?(@favorite)
                @student = Student.find(session[:student_id])
                @band = @favorite.band
                @comment = @favorite.comment
                @band_url = @favorite.band_url
                erb :'/favorites/show_favorite'
            else
                redirect '/favorites'
            end
        else
            flash[:error] = "Please login."
            redirect '/login'
        end
    end

    get '/favorites/:id/edit' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
        
            # if @favorite && @favorite.student_id == current_student.id
              if authorized_to_edit?(@favorite)
                  
                erb :'/favorites/edit_favorite'
            else
                flash[:error] = "Can only edit your own favorite bands."
                redirect '/favorites'
            end
        else
            flash[:error] = "Please login."
            redirect '/login'
        end
    end 

    patch '/favorites/:id' do
        if logged_in?
            
            band = params[:band]
            if band == ""
                flash[:error] = "Please enter favorite band's name"
               
                redirect "/favorites"
            else
                band_url = params[:band_url]
                comment = params[:comment]
                favorite = Favorite.find(params[:id])
                
                if authorized_to_edit?(favorite)
                    favorite.update(band: band, comment: comment, band_url: band_url)
                    redirect "/favorites/#{favorite.id}"
                else
                    flash[:error] = "Can only edit your own favorite people"

                    redirect "/favorites/#{@favorite.id}/edit" 
                end
            end
            
        else
            flash[:error] = "Please login."
            redirect '/login'
        end
    end

    delete '/favorites/:id/delete' do
        if logged_in?
            @favorite = Favorite.find(params[:id])
            if authorized_to_edit?(@favorite)
                @favorite.delete
            end
        redirect '/favorites'
        else
            flash[:error] = "Please login."
            redirect '/login'
        end
    end

end
