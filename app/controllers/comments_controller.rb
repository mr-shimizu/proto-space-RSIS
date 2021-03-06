class CommentsController < ApplicationController
  before_action :move_to_sign_in
  before_action :set_comment, only: [:edit, :update, :destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      respond_to do |format|
        format.html { redirect_to prototype_path(params[:prototype_id]) }
        format.json
      end
    else
      redirect_to prototype_path(params[:prototype_id])
    end
  end

  def edit
    @prototype =Prototype.find(params[:prototype_id])
  end

  def update
    if @comment.user_id == current_user.id
      @comment.update(comment_params)
    end
    redirect_to prototype_path(params[:prototype_id])
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

  def move_to_sign_in
    redirect_to new_user_session_path unless user_signed_in?
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
