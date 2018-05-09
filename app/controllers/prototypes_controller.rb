class PrototypesController < ApplicationController
  before_action :set_prototype, only: [:show, :edit, :update, :destroy]

  def index
    @prototypes = Prototype.all.page(params[:page]).per(10).order("created_at DESC")
  end

  def new
    @prototype = Prototype.new
    @prototype.captured_images.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to :root, notice: 'New prototype was successfully created'
    else
      redirect_to ({ action: new }), alert: 'New prototype was unsuccessfully created'
    end
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
    @likes = @prototype.likes
    if user_signed_in?
      @like = @prototype.like_user(current_user.id)
    end
  end

  def edit
    @captured_image = @prototype.captured_images.build
  end

  def update
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプを更新しました'
    else
      render :edit
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path, notice: '削除しました'
  end


  private

  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def prototype_params
    params.require(:prototype).permit(
      :title,
      :catch_copy,
      :concept,
      :user_id,
      :tag_list,
      captured_images_attributes: [:content, :status, :id]
      )
  end
end
