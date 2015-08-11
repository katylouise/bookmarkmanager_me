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

  # start the server if ruby file executed directly
  run! if app_file == $0
  set :views, proc { File.join(root, 'views') }
end
