module AppHelpers
  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def generate_password_token
    value = ""
    20.times{ value << (65 + rand(26)).chr }
  end
end