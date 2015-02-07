require 'rails_helper'

describe 'Sign Up' do

  before do
    visit '/'
  end

  it 'validates your password' do
    click_on 'Sign Up'
    fill_in 'Email', with: 'ttaylor@example.com'
    fill_in 'Password', with: 'short'
    fill_in 'Password confirmation', with: 'short'
    click_on 'Sign up'
    expect(page).to have_content 'is too short'
  end

  it 'lets a user sign up' do
    click_on 'Sign Up'
    fill_in 'Email', with: 'ttaylor@example.com'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome to Blerg'
    expect(page).to have_no_content 'Sign Up'
  end

  it 'lets a user log in and log out' do
    User.create!(email: 'ttaylor@example.com', password: 'password', password_confirmation: 'password')
    click_on 'Log In'
    fill_in 'Email', with: 'ttaylor@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'
    expect(page).to have_no_content 'Log In'

    click_on 'Log Out'

    expect(page).to have_content 'Sign Up'
    expect(page).to have_content 'Log In'
  end

  it 'redirects to login when user visits protected page' do
    visit '/posts'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end


end
