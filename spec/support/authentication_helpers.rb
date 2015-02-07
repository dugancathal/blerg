module AuthenticationHelpers
  def sign_in(user)
    visit '/'
    click_on 'Log In'
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
end
