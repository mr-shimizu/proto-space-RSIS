class LikesController < ApplicationController

  before_action :set_variables, only: [:create, :destroy]

  def index
    @prototypes = Prototype.all.page(params[:page]).per(10).order("likes_count DESC")
  end

  def create
    @like = Like.create(like_params)
  end

  def destroy
    like = Like.find(params[:id])
    like.destroy
  end

private

  def set_variables
    @prototype = Prototype.find(params[:prototype_id])
    @likes = @prototype.likes
  end

  def like_params
    params.permit(:prototype_id).merge(user_id: current_user.id)
  end

end
