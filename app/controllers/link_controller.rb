require_relative './base_controller'
module TheApp
  module Routes
    class Link_Controller < Base
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
    end
  end
end
