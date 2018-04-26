module ApplicationHelper

  def current_user_has?(instance)
    user_signed_in? && @prototype.user_id == current_user.id
  end

end
