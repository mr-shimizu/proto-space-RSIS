class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(content: comment_params[:content], user_id: current_user.id, prototype_id: comment_params[:prototype_id])
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
    else
      redirect_to prototype_path(@comment.prototype.id)
    end
  end

  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
    end
    redirect_to prototype_path(params[:prototype_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :prototype_id, :user_id)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
