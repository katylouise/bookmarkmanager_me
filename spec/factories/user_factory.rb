FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password '12345678'
    password_confirmation '12345678'
  end

  factory :wrong_password_user, class: User do
    email 'alice@example.com'
    password '12345678'
    password_confirmation 'wrong'
  end

  factory :no_email_user, class: User do
    email ''
    password '12345678'
    password_confirmation '12345678'
  end
end