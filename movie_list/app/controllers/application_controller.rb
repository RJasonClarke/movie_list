require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    enable :sessions
    set :session_secret, 'movielistapp2007'

    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :welcome
  end

  helpers do
    def logged_in?
      !!current_user #=> nil !nil => true => !true => false
    end

    def current_user
      @user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

end
