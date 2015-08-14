require 'spec_helper'

feature 'User sign up' do

  scenario 'I can sign up as a new user' do
    user = build(:user)
    expect { sign_up_as(user) }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'requires a matching confirmation password' do
    user = build(:wrong_password_user)
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please refer to the following errors below: Password does not match the confirmation'
  end

  scenario 'without entering email' do
    user = build(:no_email_user)
    expect { sign_up_as(user) }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Please refer to the following errors below: Email must not be blank'
  end

  scenario 'I cannot sign up with an existing email' do
    user = create(:user)
    sign_up_as(user)
    expect { sign_up_as(user) }.to change(User, :count).by(0)
    expect(page).to have_content('Email is already taken')
  end
end

feature 'User sign in' do
  scenario 'with correct credentials' do
    user = create(:user) #saves user in database so we can test against this existing user
    sign_in(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end
end

feature 'User signs out' do
  let(:user) { create(:user) }
  scenario 'while being signed in' do
    sign_in(user)
    click_button 'Sign out'
    expect(page).to have_content('Goodbye!')
    expect(page).not_to have_content('Welcome, alice@example.com')
  end
end

feature 'Password reset' do
  let(:user) { create(:user) }
  scenario 'requesting a password reset' do
    visit '/password_reset'
    fill_in 'email', with: user.email
    click_button 'Reset password'
    expect(user.password_token).not_to be_nil
    expect(page).to have_content 'Check your emails'
  end
end
