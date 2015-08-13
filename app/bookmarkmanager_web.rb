require 'sinatra/base'
require 'sinatra/flash'
require './data_mapper_setup'
require './app/helpers.rb'

class BookMarkManager < Sinatra::Base

  enable :sessions
  set :session_secret, 'super secret'
  set :views, proc { File.join(root, 'views') }

  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    link = Link.new(url: params[:url], title: params[:title])
    tag_array = params[:tag].split(" ")
    tag_array.each do |word|
      tag = Tag.create(name: word)
      link.tags << tag
    end

    link.save
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end

  get '/tags/:name' do
    tag = Tag.first(name: params[:name])
    @links = tag ? tag.links : []
    erb :'links/index'
  end

  get '/users/new' do
    @user = User.new
    erb :'users/new'
  end

  post '/users' do
    #we just initialize the object without saving it - may be invalid.
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
    if @user.save #returns true/false depending on whether model is successfully saved to db
      session[:user_id] = @user.id
      redirect to('/links')
    else
      flash.now[:errors] = @user.errors.full_messages #returns all msgs as a list
      erb :'users/new'
    end
  end

  get '/sessions/new' do
    erb :'sessions/new'
  end

  post '/sessions' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect to('/links')
    else
      flash.now[:errors] = ['The email or password is incorrect']
      erb :'sessions/new'
    end
  end

  helpers do
    include AppHelpers
  end
  # start the server if ruby file executed directly
  run! if app_file == $0

end
