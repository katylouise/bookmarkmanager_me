module TheApp
  module Routes
    class PasswordController < Base
      get '/password_reset' do
        erb :'/users/password'
      end

      post '/password_reset/:token' do
        user = User.first(email: params[:email])
        session[:token] = user.generate_password_token
        user.save
        flash[:notice] = 'Check your emails'
      end
    end
  end
end