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
      end
    end
  end
end