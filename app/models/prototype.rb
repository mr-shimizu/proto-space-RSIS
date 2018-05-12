class Prototype < ActiveRecord::Base
  acts_as_taggable

  belongs_to :user
  has_many :captured_images, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  accepts_nested_attributes_for :captured_images, reject_if: :reject_sub_images

  validates :title,
            :catch_copy,
            :concept,
            presence: true

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end

  def reject_sub_images(attributed)
    attributed['content'].blank?
  end

  def set_main_thumbnail
    captured_images.main.first.content
  end

  def posted_date
    created_at.strftime('%b %d %a')
  end

  def image_builder
    captured_images.build
  end
end
