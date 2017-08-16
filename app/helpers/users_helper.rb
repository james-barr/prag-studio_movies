module UsersHelper

  def present_user_created(object)
    object.created_at.strftime("%B %d, %Y")
  end

end
