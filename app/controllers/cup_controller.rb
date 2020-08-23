class CupController < ApplicationController

    get '/cups' do
            @cups = Cup.all
            erb :'/cups/show_cups'
    end

    get '/cups/new' do
        if logged_in?
            erb :'cups/create_cup
        else
            redirect '/login'
        end
    end