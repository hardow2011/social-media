class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      @post = @comment.post
      respond_to do |format|
        format.html { redirect_to post_path(@post), notice: 'Comment was succesfully created.' }
        format.turbo_stream
      end
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
    respond_to do |format|
      format.html { redirect_to post_path(post), notice: "Comment was successfully destroyted." }
      format.turbo_stream
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

end
