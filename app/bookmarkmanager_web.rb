require 'sinatra/base'
require 'sinatra/flash'

require './data_mapper_setup'
require './app/helpers'
require './app/controllers/base_controller'
require './app/controllers/link_controller'
require './app/controllers/tags_controller'
require './app/controllers/user_controller'
require './app/controllers/session_controller'



module TheApp
  class BookMarkManager < Sinatra::Base
    include AppHelpers
    get '/' do
      erb :index
    end

    use Routes::Link_Controller
    use Routes::Tag_Controller
    use Routes::User_Controller
    use Routes::Session_Controller
    register Sinatra::Flash



    # start the server if ruby file executed directly

  end
end
