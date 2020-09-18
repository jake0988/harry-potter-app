class HousesController < ApplicationController

    get '/houses/:id' do
        house = params[:id].capitalize
    
        if house.is_a?(Integer) && house < 5
            @name = house_conversion(house.to_i)
            @house = House.find_by(name: @name)
                
    
        elsif house == "Gryffindor" || house == "Hufflepuff" || house == "Ravenclaw" || house == "Slytherin"
            @house = House.find_by(name: house)
            @name = @house.name.downcase
            
        end
          
            if logged_in?            
                erb :"/houses/#{@name}"
            
            else
            redirect '/login'
        
        end
    end
    
       
end