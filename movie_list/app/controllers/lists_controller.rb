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
end