require 'rails_helper'

describe 'Commentating' do
  it 'occurs on the post page' do
    user = create_user
    post = Post.create!(message: 'my fancy post', user: user, published: true)

    sign_in user

    click_on 'my fancy post'

    fill_in 'Body', with: 'My comment'
    click_on 'Add Comment'

    expect(page).to have_content 'My comment'
    expect(page).to have_content 'my fancy post'
  end
end
