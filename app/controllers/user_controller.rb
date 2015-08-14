module TheApp
  module Routes
    class User_Controller < Base
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
  end
end
end