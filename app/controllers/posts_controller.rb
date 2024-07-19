class PostsController < ApplicationController
  include CommunitySetting

  skip_before_action :authenticate_user!, only: %i[show]

  before_action :set_post, only: %i[show edit update destroy vote_post]
  before_action only: %i[new edit destroy] do
    set_community_by_handle(params[:community_id])
  end

  def index
    @communities = Community.all
    @posts = Post.ordered
  end

  def show
    @comment = @post.comments.build
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    community = Community.get_by_handle(params[:community_id])
    @post.community = community

    if @post.save
      redirect_to community_path(@post.community), notice: "Post was successfuly created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to community_path(@post.community), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to community_path(@community), notice: "Post was successfully destroyted."
  end

  def vote_post
    # TODO: refactor conversion
    upvote = ActiveModel::Type::Boolean.new.cast(params[:upvote])

    vote = Vote.where(votable: @post, user: current_user).first_or_initialize
    if !vote.new_record?
      if vote.upvote == upvote
        vote.destroy
      else
        vote.upvote = !upvote
        vote.save
      end
    else
      vote.upvote = upvote
      if vote.save
      end
    end
    redirect_to community_path(@post.community), notice: "Post was successfully liked."
  end


  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :community_id)
  end
end
