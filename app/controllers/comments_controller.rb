class CommentsController < ApplicationController

  def create
    @comment = Comment.create(content: comment_params[:content], user_id: current_user.id, prototype_id: comment_params[:prototype_id])
    redirect_to prototype_path(@comment.prototype.id)   #コメントと結びつく詳細画面に遷移する
  end

  private
  def comment_params
    params.permit(:content, :prototype_id, :user_id)
  end
end
