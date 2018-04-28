class CommentsController < ApplicationController

  def create
    @comment = Comment.new(content: comment_params[:content], user_id: current_user.id, prototype_id: comment_params[:prototype_id])
    if @comment.save
      redirect_to prototype_path(@comment.prototype.id)
    else
      redirect_to prototype_path(@comment.prototype.id)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :prototype_id, :user_id)
  end
end
