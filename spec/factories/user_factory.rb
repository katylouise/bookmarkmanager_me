FactoryGirl.define do
  factory :user do
    email 'alice@example.com'
    password '12345678'
    password_confirmation '12345678'

    factory :wrong_password_user do
      password_confirmation 'wrong'
    end

    factory :no_email_user do
      email ''
    end
  end
end
