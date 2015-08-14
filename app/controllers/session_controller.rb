module TheApp
  module Routes
    class Session_Controller < Base

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

    delete '/sessions' do
      session.clear
      flash.now[:notice] = ['Goodbye!']
    end
end
end
end