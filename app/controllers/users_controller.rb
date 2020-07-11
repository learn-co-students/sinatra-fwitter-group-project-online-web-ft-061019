class UsersController < ApplicationController

    get '/login' do 
        if logged_in?
            redirect to '/tweets'
        else 
            erb :'users/login'
        end 
    end 

    post '/login' do 
        user = User.find_by(:username => params[:username])
        login(params[:username], params[:password])
        session[:user_id] = @user.id 
        redirect '/tweets'
    end 

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else 
            erb :'users/signup'
        end 
    end 

    post '/signup' do 
        if params[:username] == "" || params[:password]== "" 
            redirect '/signup'
        else
            @user = User.new(:username => params[:username], :password => params[:password])
            @user.save
            session[:user_id] = @user.id
            redirect to '/tweets'
        end 
    end 

    get '/logout' do 
        if logged_in?
            logout 
            redirect to '/'
        else  
            redirect to '/login'
        end 
    end 

end 