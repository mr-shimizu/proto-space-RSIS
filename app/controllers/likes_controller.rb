class LikesController < ApplicationController
  def create
    @like = Like.create(like_params)
    redirect_to prototype_path(id: params[:prototype_id])
  end

  def destroy
    @like = Like.find(params[:id])
    @like.destroy
    redirect_to prototype_path(id: params[:prototype_id])
  end

private

  def like_params
    params.permit(:prototype_id).merge(user_id: current_user.id)
  end

end
