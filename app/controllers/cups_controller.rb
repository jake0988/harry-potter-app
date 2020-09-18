class CupsController < ApplicationController

    get '/cups' do
            @cups = CupWinner.all
                
            erb :'/cups/show_cups'
    end

    get '/cups/new' do
      
        if admin_logged_in?
            erb :'/cups/create_cup'
        else
            redirect '/cups'
        end
    end

    post '/cups/new' do
        year = params[:cup][:year]
        name = params[:cup][:name]
        cup = CupWinner.create(:name => name)
        cup.year = year
        cup.save
        redirect '/cups'
    end

end