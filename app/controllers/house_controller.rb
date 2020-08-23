class HouseController < ApplicationController
    get '/house/new' do
        @houses = House.all
        erb '/houses/create_house'
    end

    post '/house/new' do
        @house = House.new(params[:name])

    end
    
    get '/house/:id' do
        if logged_in?
            @house = House.find_by(name: => params[:id])
            erb :"houses/#{@house.name}"
        else
            redirect '/login'
        end
    end