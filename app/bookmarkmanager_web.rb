require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/partial'
require './data_mapper_setup'
require './app/helpers'
require './app/controllers/base_controller'
require './app/controllers/link_controller'
require './app/controllers/tags_controller'
require './app/controllers/user_controller'
require './app/controllers/session_controller'
require './app/controllers/password_controller'

module TheApp
  class BookMarkManager < Sinatra::Base
    include AppHelpers
    get '/' do
      erb :index
    end

    use Routes::LinkController
    use Routes::TagController
    use Routes::UserController
    use Routes::SessionController
    use Routes::PasswordController
    register Sinatra::Flash
    register Sinatra::Partial
  end
end
