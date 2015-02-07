require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  describe 'POST #create' do
    it 'adds the comment to the post' do
      sign_in create_user
      post1 = Post.create!(message: 'stuff')
      expect {
        post :create, comment: {post_id: post1.id}
      }.to change { post1.comments.count }.by(1)
    end

    it 'adds the comment to the current user' do
      user = create_user
      sign_in user
      post1 = Post.create!(message: 'stuff')
      expect {
        post :create, comment: {post_id: post1.id}
      }.to change { user.comments.count }.by(1)
    end
  end
end
