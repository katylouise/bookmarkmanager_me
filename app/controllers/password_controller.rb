module TheApp
  module Routes
    class PasswordController < Base
      get '/password_reset' do
        erb :'/users/password'
      end

      post '/password_reset' do
        user = User.first(email: params[:email])
        session[:token] = user.generate_password_token
        user.save
        flash[:notice] = 'Check your emails'
      end

      get '/password_reset/:token' do
        erb :'/users/password_reset'
      end

      post '/password_reset/:token' do
        user = User.first(email: params[:email])
        # if session[:token] == user.password_token
          user.password = params[:new_password]
          'Your password has been changed!'
          session.clear
        # end
      end
    end
  end
end