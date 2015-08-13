
feature 'User sign in' do
  scenario 'with correct credentials' do
    user = create(:user) #saves user in database so we can test against this existing user
    sign_in(user)
    expect(page).to have_content "Welcome, #{user.email}"
  end

  def sign_in(user)
    visit '/sessions/new'
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    click_button 'Sign in'
  end
end
