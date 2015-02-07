class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    @posts = Post.where(published: true)
  end
end
