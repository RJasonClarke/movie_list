class ListsController < ApplicationController
    before '/lists/*' do
        authentication_required
    end

    get '/lists' do
        @lists = current_user.lists
        erb :'lists/index'
    end

    get '/lists/new' do
        erb :'lists/new'
    end

    get '/lists/:id' do
        @list = current_user.lists.find(params[:id])

        erb :'lists/show'
    end

    post '/lists' do
        @list = List.new
        @list.name = params[:name]
        @list.user = current_user

        if @list.save
            redirect '/lists'
        else
            erb :'lists/new'
        end
    end

    get '/lists/:id/edit' do
        @list = current_user.lists.find(params[:id])
        erb :"lists/edit"
    end

    patch '/lists/:id' do
        @list = current_user.lists.find(params[:id])
        @list.update(name: params[:name])
        redirect "/lists"
    end

    delete '/lists/:id' do
        @list = current_user.lists.find(params[:id])
        @list.destroy
        redirect '/lists'
    end

    post '/lists/:id/movies' do
        @list = current_user.lists.find(params[:id])
        @movie = @list.movies.build(:url => params[:url])
        if @movie.save
            redirect "/lists/#{@list.id}"
        else
            erb :"lists/show"
        end
    end

end