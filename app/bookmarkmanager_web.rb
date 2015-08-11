require 'sinatra/base'
require './data_mapper_setup'

class BookMarkManager < Sinatra::Base
  get'/' do
    'Hello BookMarkManager'
  end

  get '/links' do
    @links = Link.all
    erb :'links/index'
  end

  post '/links' do
    Link.create(url: params[:url], title: params[:title])
    redirect to('/links')
  end

  get '/links/new' do
    erb :'links/new'
  end
  # start the server if ruby file executed directly
  run! if app_file == $0
  set :views, proc { File.join(root, '..', 'views') }
end
