require 'rails_helper'

describe 'Posting' do
  let(:user) { create_user }

  describe 'home page' do
    before do
      post = Post.create!(message: 'Test post message', published: true, user: user)
      private_post = Post.create!(message: 'Test published post message', published: false, user: user)
      visit '/'
    end

    it 'shows published posts on the home page' do
      expect(page).to have_content 'Test post message'
      expect(page).to have_no_content 'Test published post message'
    end
  end

  describe 'post show pages' do
    it 'lets unauthenticated users view them' do
      post = Post.create!(message: 'Chris post', published: true)
      visit post_path(post)
      expect(page).to have_content 'Chris post'
    end
  end

  context 'when logged in' do
    let(:user) { User.create!(email: 'ttaylor@example.com', password: 'password', password_confirmation: 'password') }
    before do
      visit '/'
      sign_in user
    end

    it 'lets the user create a post' do
      click_on 'New Post'
      fill_in 'Message', with: 'This is my first post'
      check 'Published'
      click_on 'Submit'

      expect(page).to have_content 'Post successful'
      within '.post', text: 'first post' do
        expect(page).to have_content 'This is my first post'
        expect(page).to have_content '(published)'
      end
    end

    it 'lets the user edit a post' do
      click_on 'New Post'
      fill_in 'Message', with: 'This is my first post'
      click_on 'Submit'

      within '.post', text: 'first post' do
        click_on 'Edit Post'
      end

      check 'Published'
      click_on 'Submit'

      within '.post', text: 'first post' do
        expect(page).to have_content '(published)'
      end
    end

    it 'shows published posts' do
      post = Post.create!(message: 'Test post message', published: true, user: user)
      private_post = Post.create!(message: 'Test published post message', published: false, user: user)
      visit '/'
      expect(page).to have_content 'Test post message'
      expect(page).to have_no_content 'Test published post message'
    end

    it "shows the user's posts" do
      Post.create!(message: 'My first post', user: user)
      Post.create!(message: 'Not my post')
      visit '/'
      click_on 'My Posts'
      expect(page).to have_content 'My first post'
      expect(page).to have_no_content 'Not my post'
    end

    it 'lets the user delete posts' do
      Post.create!(message: 'My first post', user: user)
      click_on 'My Posts'
      click_on 'Delete Post'
      expect(page).to have_no_content 'My first post'
    end
  end

  describe 'multiple user posting' do
    let(:chris) { User.create!(email: 'chris@example.com', password: 'password', password_confirmation: 'password') }
    let(:arjun) { User.create!(email: 'arjun@example.com', password: 'password', password_confirmation: 'password') }
    before do
      Post.create!(message: 'Chris post', user: chris, published: true)
      Post.create!(message: 'Arjun post', user: arjun, published: true)
      Post.create!(message: 'Chris post 2', user: chris, published: false)
    end

    describe 'home page' do
      it 'shows all the published posts' do
        visit '/'
        expect(page).to have_content 'Chris post'
        expect(page).to have_no_content 'Chris post 2'
        expect(page).to have_content 'Arjun post'
      end
    end

    describe 'post management page' do
      it 'only shows the current user posts' do
        sign_in chris
        click_on 'My Posts'
        expect(page).to have_content 'Chris post'
        expect(page).to have_content 'Chris post 2'
      end
    end
  end
end
