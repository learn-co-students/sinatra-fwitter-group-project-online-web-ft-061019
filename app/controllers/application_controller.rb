require 'bcrypt'
require './config/environment'

class ApplicationController < Sinatra::Base

    configure do 
        set :public_folder, 'public'
        set :views, 'app/views'
        enable :sessions
        set :session_secret, "c00kb00kHaSsEcUrEl0gIn"
    end 

    get '/' do 
        erb :index
    end 

    helpers do 
        def logged_in?
            !!session[:user_id]
        end 

        def current_user
            User.find(session[:user_id])
        end 

        def login(username, password) 
            @user = User.find_by(:username => params[:username])
            if @user && @user.authenticate(params[:password])
                session[:user_id] = @user.id
                redirect to '/tweets'
            else 
                redirect to '/signup'
            end 
        end 

        def logout 
            session.destroy
        end 
    end 
     
end 