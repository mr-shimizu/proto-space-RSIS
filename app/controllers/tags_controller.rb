class TagsController < ApplicationController

  def index
    @tags = ActsAsTaggableOn::Tag.most_used.where('taggings_count > 0')
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find_by(name: params[:tag_name])
    @prototypes = Prototype.tagged_with(@tag)
  end

  def search
    @tags = ActsAsTaggableOn::Tag.where('name LIKE(?)', "%#{params[:keyword]}%").where('taggings_count > 0').limit(10)
    respond_to do |format|
      format.html
      format.json
    end
  end

end
