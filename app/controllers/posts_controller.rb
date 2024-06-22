class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy like_post]

  def index
    @posts = Post.ordered
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to posts_path, notice: "Post was successfuly created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post was successfully destroyted."
  end

  def like_post
    like = Like.where(post: @post, user: current_user)
    if like.any?
      like.delete_all
    else
      Like.create(post: @post, user: current_user)
    end
    redirect_to posts_path, notice: "Post was successfully liked."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption)
  end
end
