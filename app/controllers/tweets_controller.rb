class TweetsController < ApplicationController 

    get '/tweets' do 
        if !logged_in? 
            redirect '/login'
        else     
            @tweets = Tweet.all
            @user = User.find_by_id(session[:user_id])
            erb :'/tweets/tweets'
        end 
    end 

   get '/tweets/new' do 
        if !logged_in?
            redirect '/login'
        else
            erb :'/tweets/new'
        end 
    end 

    post '/tweets' do 
        if params[:title] == "" || params[:content] == ""
            redirect '/tweets/new'
        else
            @tweet = Tweet.create(:title => params[:title], :content => params[:content], :user_id => session[:user_id])
            @tweet.user_id = session[:user_id]
            @tweet.save
            redirect "/tweets/#{@tweet.id}"
        end 
    end 

    get '/tweets/:id' do 
        if !logged_in?
            redirect '/login'
        else
            @tweet = Tweet.find_by_id(params[:id])
            @user = User.find_by_id(params[:id])
            erb :'/tweets/show'
        end 
    end 

    get '/tweets/:id/edit' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if current_user.id == @tweet.user_id
                erb :'/tweets/edit'
            else 
                redirect '/tweets'
            end 
        else
            redirect '/login'
        end 
    end 

    patch '/tweets/:id' do 
        if params[:title] == "" || params[:content] == ""
            redirect '/tweets/#{params[:id]}/edit'
        else
            @tweet = Tweet.find_by_id(params[:id])
            @tweet.title = params[:title]
            @tweet.content = params[:content]
            @tweet.save 
            redirect '/tweets'
        end 
    end 

    delete '/tweets/:id/delete' do 
        if logged_in?
            @tweet = Tweet.find_by_id(params[:id])
            if current_user.id == @card.user_id
                @tweet.delete
                redirect '/tweets'
            else 
                redirect '/tweets'
            end 
        else
            redirect '/login'
        end 
    end 

end 