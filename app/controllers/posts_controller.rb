class PostsController < ApplicationController
  skip_before_filter :authenticate_user!, only: :show
  def index
    @posts = Post.where(user: current_user)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))
    if @post.save
      redirect_to posts_path, notice: 'Post successful'
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes post_params
      redirect_to posts_path, notice: 'Post successful'
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path, notice: 'Post deleted'
  end

  private
  def post_params
    params.require(:post).permit(:message, :published)
  end
end
