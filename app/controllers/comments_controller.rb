class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)

    if @comment.save
      redirect_to post_path(@post), notice: 'Comment was succesfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit

  end

  def update
    if @comment.update(comment_params)
      post = @comment.post
      redirect_to post_path(post), notice: "Comment was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    post = @comment.post
    @comment.destroy
    redirect_to post_path(post), notice: "Comment was successfully destroyted."
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
