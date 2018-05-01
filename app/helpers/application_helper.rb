module ApplicationHelper

  def current_user_has?(instance)
    user_signed_in? && instance.user_id == current_user.id
  end

end
