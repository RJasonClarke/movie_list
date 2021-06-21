class UsersController < ApplicationController

    get '/signup' do
        erb :'users/new'       
    end

    post '/users' do
        @user = User.new
        @user.email = params[:email]
        @user.password = params[:password]

        if @user.save
            redirect '/login'
        else
            erb :'users/new'
        end
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        @user = User.find_by(:email => params[:email])
        if @user && @user.authenticate(params[:password])
            session['user_id'] = @user.id
            redirect '/'
        else
            erb :'users/login'
        end
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

end