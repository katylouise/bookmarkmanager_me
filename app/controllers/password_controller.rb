module TheApp
  module Routes
    class PasswordController < Base
      get '/password_reset' do
        erb :'/users/password'
      end

      post '/password_reset' do
        user = User.first(email: params[:email])
        user.password_token = generate_password_token
        user.save
        'Check your emails'
        #Save token as a session var session[:token]
        #page to go to is password_reset/:token
      end
    end
  end
end