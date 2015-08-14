module AppHelpers
  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def generate_password_token
    (0..20).map { (65 + rand(26)).chr }.join
  end
end