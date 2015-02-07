require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  include Devise::TestHelpers
  let(:user) { User.create!(email: 'test@example.com', password: 'password', password_confirmation: 'password') }
  before do
    sign_in user
  end

  describe 'GET #index' do
    it 'only shows the current user posts' do
      my_post = Post.create!(message: 'stuff', user: user)
      Post.create!(message: 'stuff2', user: nil)
      get :index
      expect(assigns(:posts)).to eq([my_post])
    end
  end

  describe 'POST #create' do
    context 'on success' do
      it 'should redirect to the posts page' do
        post :create, post: {message: 'My Message'}
        expect(response).to redirect_to posts_path
      end

      it 'creates a post' do
        expect {
          post :create, post: {message: 'My Message'}
        }.to change { user.posts.count }.by(1)
      end

      it 'sets the flash' do
        post :create, post: {message: 'My Message'}
        expect(flash[:notice]).to eq 'Post successful'
      end
    end

    context 'with invalid parameters' do
      it 'fails to create the post' do
        expect {
          post :create, post: {stuff: 1}
        }.to_not change(Post, :count)
      end

      it 'rerenders the form' do
        post :create, post: {stuff: 1}
        expect(response).to render_template :new
      end
    end
  end
end
