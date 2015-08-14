require 'sinatra/base'
require 'sinatra/flash'
require './app/helpers'
require_relative '../../data_mapper_setup'


module TheApp
  module Routes
    class Base < Sinatra::Base
      include AppHelpers
      enable :sessions
      register Sinatra::Flash
      use Rack::MethodOverride
      set :session_secret, 'super secret'
      set :views, proc { File.join(root, '..', 'views') }
      set :partial_template_engine, :erb
      # start the server if ruby file executed directly
      run! if app_file == $0
    end
  end
end